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
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying < 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyPerbaikanBalaiDesaFirst
                        matchManager.isFinishedPlaying = 0
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
                    ComponentButtonMic(textButton: matchManager.isFinishedPlaying < 2 ? "Menunggu temanmu selesai..." : "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .storyPerbaikanBalaiDesaSecond
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
                    ComponentButtonMic(textButton: "Keluar", isWithIcon: false) {
                        matchManager.gameStatus = .setup
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
