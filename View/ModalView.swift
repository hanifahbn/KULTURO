//
//  ModalView.swift
//  MacroApp
//
//  Created by Hanifah BN on 30/10/23.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var matchManager: MatchManager
    @State var modalType: String? = "Waiting"
    
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            if(modalType == "Waiting"){
                VStack{
                    Text("Yeay, kamu berhasil membeli semua peralatan!")
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.center)
                    ComponentButtonMic(textButton: "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .convoGudang
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            if(modalType == "CameraSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil menemukan semua peralatan!")
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.center)
                    ComponentButtonMic(textButton: "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .convoBantuDesa
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            if(modalType == "DragAndDropSuccess"){
                VStack{
                    Text("Yeay, kamu berhasil menemukan semua peralatan!")
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.center)
                    ComponentButtonMic(textButton: "Lanjutkan", isWithIcon: false) {
                        matchManager.gameStatus = .convoBantuDesa
                    }
                    .disabled(matchManager.isFinishedPlaying != 2)
                }
            }
            else if(modalType == "Lose"){
                VStack{
                    Text("Waktu habis, kamu belum berhasil.")
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.red)
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
