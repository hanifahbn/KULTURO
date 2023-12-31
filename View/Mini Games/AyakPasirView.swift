//
//  AyakPasirView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 26/10/23.
//

import SwiftUI
import CoreMotion

struct AyakPasirView: View {
    @EnvironmentObject var matchManager: MatchManager
    @State private var isFlying = false
    @State private var motionManager = CMMotionManager()
    @State private var flyCounter = 0
    @State private var isModalPresented = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    let timerInterval = 1.0
    @State private var isTutorial = true
    @State private var waveAngle: Double = 0.0
    @State var isSuccess: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false
    
    var hapticViewModel = HapticViewModel()
    
    enum SheetType {
        case shakeSuccess
        case shakeSuccessAll
        case lose
    }
    
    var body: some View {
        GeometryReader{ geometry in
        ZStack {
            Image("Backgroundpasir")
                .resizable()
                .ignoresSafeArea()
            ZStack {
                VStack{
                    HStack{
                        Spacer()
                        TimerView(countTo: 121)
                            .environmentObject(matchManager)
                    }
                    Spacer()
                }
            }
            .zIndex(1)
            .padding(.trailing,geometry.size.height * 0.05)
            //            .padding(40)
            ZStack {
                Image("Ayak")
                    .resizable()
//                    .frame(width: 420, height: 800)
                    .frame(width: geometry.size.width / 1, height: geometry.size.height * 1)
                    .offset(x: isFlying ? -10 : 10)
                    .animation(.bouncy, value: isFlying)
                Image("Pasir")
                    .resizable()
                    .frame(width: 250, height: 350)
                    .offset(x: isFlying ? 30 : -5)
                    .animation(.bouncy(duration: 1), value: isFlying)
                    .padding(.bottom, 50)
            }
            .padding(.top, 40)
            
            if flyCounter == 15 {
                ZStack{
                    Image("PasirAkhir")
                        .resizable()
                        .frame(width: geometry.size.width / 1, height: geometry.size.height * 1)
                    //                        .animation(.easeOut(duration: 1), value: flyCounter)
                        .onAppear {
                            matchManager.isFinishedPlaying += 1
                            matchManager.synchronizeGameState("AyakPasirMission")
                            isSuccess = true
                        }
                }
            }
            ZStack{
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.8)
                VStack{
                    Text("Goyangkan handphone kalian bersamaan untuk memisahkan pasir dan batu.")
                        .foregroundStyle(.white)
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .padding(30)
                    ZStack{
                        Image("ShakeTutorial")
                            .rotationEffect(.degrees(waveAngle))
                            .animation(Animation.easeInOut(duration: 1.0).repeatForever(),value: waveAngle)
                            .onAppear {
                                withAnimation {
                                    waveAngle = 30.0
                                }
                            }
                        Image("ShakeEffect")
                    }
                    .padding(.bottom, 50)
                    
                }
            }
            .zIndex(3)
            .opacity(isTutorial ? 1 : 0)
        }
    }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Color.ungu
                    .ignoresSafeArea()
                switch currentSheet {
                case .shakeSuccess:
                    ModalView(modalType: "AyakPasirSuccess", textButton: "Menunggu temanmu selesai...")
                        .environmentObject(matchManager)
                case .shakeSuccessAll:
                    ModalView(modalType: "AyakPasirSuccess", textButton: "Lanjutkan")
                        .environmentObject(matchManager)
                case .lose:
                    ModalView(modalType: "Lose", backTo: .cameraGame)
                        .environmentObject(matchManager)
                case .none:
                    VStack {
                        EmptyView()
                    }
                    .onAppear{
                        isSuccess.toggle()
                        isSuccess.toggle()
                    }
                }
            }
            .interactiveDismissDisabled()
            .presentationDetents([.height(190)])
        }
        .onAppear{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                startMotionUpdates()
                matchManager.startTimer(time: 21)
//            }
        }
        .onTapGesture {
            isTutorial = false
        }
        .onChange(of: isSuccess) { _ in
            updateSheets()
        }
        .onChange(of: matchManager.isTimerRunning) { _ in
            updateSheets()
        }
        .onChange(of: matchManager.isFinishedPlaying) { _ in
            updateSheets()
        }
    }
    
    func startMotionUpdates() {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
            if let acceleration = accelerometerData?.acceleration {
                let shakeThreshold: Double = 2
                if abs(acceleration.x) > shakeThreshold || abs(acceleration.y) > shakeThreshold || abs(acceleration.z) > shakeThreshold {
                    // Device is shaken, trigger the fly animation
                    isFlying = true
                    flyCounter += 1
                    if flyCounter == 15 {
                        // Disable onAppear after 10 times
                        self.motionManager.stopAccelerometerUpdates()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isFlying = false
                    }
                }
            }
        }
    }
    
    private func updateSheets() {
        if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying == 2 {
            currentSheet = .shakeSuccessAll
            isSheetPresented = true
            hapticViewModel.complexSuccess()
        } else if isSuccess && !matchManager.isTimerRunning && matchManager.isFinishedPlaying < 2 {
            currentSheet = .lose
            isSheetPresented = true
            hapticViewModel.simpleError()
        } else if !isSuccess && !matchManager.isTimerRunning {
            currentSheet = .lose
            isSheetPresented = true
            hapticViewModel.simpleError()
        }
    }
}

#Preview {
    AyakPasirView()
        .environmentObject(MatchManager())
}
