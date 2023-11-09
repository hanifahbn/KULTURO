//
//  ModalView.swift
//  MacroApp
//
//  Created by Hanifah BN on 30/10/23.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var matchManager: MatchManager
    @State var modalType: String? = "SoundSuccess"
    @State var textButton: String? = ""
    @State var backTo: GameStatus = .setup
    
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            if(modalType == "SoundSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil membeli semua peralatan!")
                        .font(.system(size: 23, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying < 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyGudang
                        matchManager.isRetrying = false
                        matchManager.isFinishedPlaying = 0
                        matchManager.isFinishedReading = 0
                        matchManager.stopTimer()
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            if(modalType == "CameraSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil menemukan semua peralatan!")
                        .font(.system(size: 23, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying != 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyPerbaikanBalaiDesaFirst
                        matchManager.isRetrying = false
                        matchManager.isFinishedPlaying = 0
                        matchManager.isFinishedReading = 0
                        matchManager.stopTimer()
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            if(modalType == "DragAndDropSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil menemukan semua peralatan!")
                        .font(.system(size: 23, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying != 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyPerbaikanBalaiDesaSecond
                        matchManager.isRetrying = false
                        matchManager.isFinishedPlaying = 0
                        matchManager.isFinishedReading = 0
                        matchManager.stopTimer()
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            if(modalType == "AyakPasirSuccess"){
                VStack{
                    Text("Yeay, kita berhasil membuat pasir menjadi lebih halus!")
                        .font(.system(size: 23, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying < 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyBalaiDesaRenovated
                        matchManager.isRetrying = false
                        matchManager.isFinishedPlaying = 0
                        matchManager.isFinishedReading = 0
                        matchManager.stopTimer()
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            else if(modalType == "Lose"){
                VStack{
                    Text("Waktu habis, kamu dan temanmu belum berhasil.")
                        .font(.system(size: 23, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.red)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: "Ulangi", isWithIcon: false) {
                        matchManager.isRetrying = true
                        matchManager.isFinishedPlaying = 0
                        matchManager.isFinishedReading = 0
                        matchManager.stopTimer()
                    }
                }
            }
        }
    }
}

#Preview {
    ModalView()
        .environmentObject(MatchManager())
}
