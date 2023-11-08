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
                        .frame(width: 110, height: 55)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .overlay(content: {
                            HStack{
                                Image(systemName: "timer")
                                    .font(.system(size: 25, weight: .bold))
                                Text(matchManager.timeInString)
                                    .font(.system(size: 17, weight: .bold))
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
//            .opacity(flyCounter == 10 ? 0 : 1)
            .padding(.top, 50)
            if flyCounter == 10 {
                ZStack{
                    Image("PasirAkhir")
                        .resizable()
                        .frame(width: 400, height: 900)
//                        .animation(.easeOut(duration: 1), value: flyCounter)
                        .onAppear{
                            matchManager.isFinishedPlaying += 1
                            matchManager.synchronizeGameState("AyakPasirMission")
                            isModalPresented = true
                        }
                }
            }
            ZStack{
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.5)
                Text("Goyangkan handphone kalian bersamaan untuk memisahkan pasir dan batu")
                    .foregroundStyle(.white)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(30)
            }
            .opacity(isTutorial ? 1 : 0)
        }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
        .sheet(isPresented: Binding(
            get: { matchManager.isTimerRunning == true && matchManager.isFinishedPlaying > 0 },
            set: { _ in }
        )) {
            ModalView(modalType: "AyakPasirSuccess")
                .environmentObject(matchManager)
                .presentationDetents([.height(190)])
        }
        .sheet(isPresented: Binding(
            get: { matchManager.isTimerRunning == false && matchManager.isFinishedPlaying != 2},
            set: { _ in }
        )) {
            ModalView(modalType: "Lose")
                .environmentObject(matchManager)
                .presentationDetents([.height(190)])
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isTutorial = false
                startMotionUpdates()
                startTimer()
//                matchManager.isTimerRunning = true
                matchManager.startTimer(time: 11)
//                matchManager.isFinishedPlaying = 0
            }
        }
    }
    func startTimer() {
        isTimerRunning = true
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            elapsedTime += timerInterval
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
                    if flyCounter == 10 {
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

#Preview {
    AyakPasirView()
        .environmentObject(MatchManager())
}
