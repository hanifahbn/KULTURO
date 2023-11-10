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
    @StateObject var viewModel = TransitionViewModel()

    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            if(modalType == "SoundSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil membeli semua peralatan!")
                        .font(.custom("Chalkboard-Regular", size: 23))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying < 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyGudang
                        matchManager.isFinishedPlaying = 0
                        matchManager.isFinishedReading = 0
                        matchManager.stopTimer()
                        viewModel.startTransition()
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            if(modalType == "CameraSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil menemukan semua peralatan!")
                        .font(.custom("Chalkboard-Regular", size: 23))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying != 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyPerbaikanBalaiDesaFirst
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
                        .font(.custom("Chalkboard-Regular", size: 23))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying != 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyPerbaikanBalaiDesaSecond
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
                        .font(.custom("Chalkboard-Regular", size: 23))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying < 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyBalaiDesaRenovated
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
                        .font(.custom("Chalkboard-Regular", size: 23))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.red)
                        .padding(.horizontal, 35)
                    ComponentButtonMic(textButton: "Keluar", isWithIcon: false) {
                        matchManager.gameStatus = .setup
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
