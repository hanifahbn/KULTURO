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
    
    var timerText: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d.%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            Image("Backgroundpasir")
                .resizable()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 120, height: 54)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .overlay(content: {
                            HStack{
                                Image(systemName: "timer")
                                    .font(.system(size: 32, weight: .bold))
                                Text(timerText)
                                    .font(.system(size: 19, weight: .bold))
                            }
                        })
                }
                Spacer()
            }
            .padding(40)
            ZStack {
                Image("Ayak")
                    .resizable()
                    .frame(width: 420, height: 800)
                    .offset(x: isFlying ? -10 : 10)
                    .animation(.bouncy, value: isFlying)
                Image("Pasir")
                    .resizable()
                    .frame(width: 250, height: 350)
                    .offset(x: isFlying ? 30 : -5)
                    .animation(.bouncy(duration: 1), value: isFlying)
                    .padding(.bottom, 50)
            }
            .padding(.top, 50)
            if flyCounter > 12 && elapsedTime == 30 {
                Image("PasirAkhir")
                    .resizable()
                    .frame(width: 400, height: 900)
                    .animation(.easeOut(duration: 1), value: flyCounter)
            }
        }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
//        .sheet(isPresented: $isModalPresented) {
//            ModalPasirView(isModalPresented: $isModalPresented)
//                .presentationDetents([.height(190)])
//        }
//        .sheet(isPresented: Binding(
//            get: { matchManager.isTimerRunning == true && isModalPresented },
//            set: { _ in }
//        )) {
//            ModalView(modalType: "AyakPasirSuccess")
//                .environmentObject(matchManager)
//                .presentationDetents([.height(190)])
//        }
//        .sheet(isPresented: Binding(
//            get: { matchManager.isTimerRunning == false },
//            set: { _ in }
//        )) {
//            ModalView(modalType: "Lose")
//                .environmentObject(matchManager)
//                .presentationDetents([.height(190)])
//        }
        .sheet(isPresented: $isModalPresented) {
            if matchManager.isTimerRunning == false && matchManager.isFinishedPlaying != 2 {
                ModalView(modalType: "Lose")
                    .environmentObject(matchManager)
                    .presentationDetents([.height(190)])
            } else if matchManager.isTimerRunning == true && matchManager.isFinishedPlaying != 2 {
                ModalView(modalType: "AyakPasirSuccess")
                    .environmentObject(matchManager)
                    .presentationDetents([.height(190)])
            }
        }
        .onAppear{
            startMotionUpdates()
            startTimer()
            matchManager.isTimerRunning = true
            matchManager.startTimer(time: 10)
        }
    }
    func startTimer() {
        isTimerRunning = true
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            elapsedTime += timerInterval
            if elapsedTime >= 5 && flyCounter == 0 {
//                timer.invalidate()
                isTimerRunning = false
                print("kamu gagal")
                isModalPresented = true
            } else if flyCounter > 1 && elapsedTime == 5{
                isModalPresented = true
                matchManager.isFinishedPlaying += 1
                matchManager.synchronizeGameState("AyakPasirMission")
                if matchManager.isFinishedPlaying == 2 {
                    isModalPresented = true
                }
                isTimerRunning = false
            }
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
                    if flyCounter >= 100 {
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
}


//#Preview {
//    AyakPasirView()
//        .environmentObject(MatchManager())
//}

//struct ModalPasirView: View {
//    @Binding var  isModalPresented : Bool
//    var body: some View {
//        ZStack{
//            Color.ungu
//                .ignoresSafeArea()
//            VStack{
//                Text("Yeay, kita berhasil membuat pasir menjadi lebih halus!")
//                    .font(.system(size: 25, weight: .bold))
//                    .multilineTextAlignment(.center)
//                ComponentButtonMic(textButton: "Lanjutkan", iconButton: "") {
//                    isModalPresented = false
//                }
//            }
//        }
//    }
//}

