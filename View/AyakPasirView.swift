//
//  AyakPasirView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 26/10/23.
//


import SwiftUI
import CoreMotion

struct AyakPasirView: View {
    @State private var isFlying = false
    @State private var motionManager = CMMotionManager()
    @State private var flyCounter = 0
    @State private var isModalPresented = false
    
    var body: some View {
        ZStack {
            Image("Backgroundpasir")
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
            if flyCounter >= 10 {
                Image("PasirAkhir")
                    .resizable()
                    .frame(width: 400, height: 900)
                    .animation(.easeOut(duration: 1), value: flyCounter)
            }
        }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
        .sheet(isPresented: $isModalPresented) {
            ModalPasirView(isModalPresented: $isModalPresented)
                .presentationDetents([.height(190)])
        }
        .onAppear {
            startMotionUpdates()
        }
    }

    func startMotionUpdates() {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
            if let acceleration = accelerometerData?.acceleration {
                let shakeThreshold: Double = 1.2
                if abs(acceleration.x) > shakeThreshold || abs(acceleration.y) > shakeThreshold || abs(acceleration.z) > shakeThreshold {
                    // Device is shaken, trigger the fly animation
                    isFlying = true
                    flyCounter += 1
                    if flyCounter >= 10 {
                        // Disable onAppear after 10 times
                        self.motionManager.stopAccelerometerUpdates()
                        isModalPresented = true
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
}

struct ModalPasirView: View {
    @EnvironmentObject var router : Router
    @Binding var  isModalPresented : Bool
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            VStack{
                Text("Yeay Kita berhasil membuat pasir menjadi lebih halus!")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                ComponentButtonMic(textButton: "Lanjutkan", iconButton: "") {
                    router.path.append(.endStories)
                    isModalPresented = false
                }
            }
        }
    }
}
