//
//  MissionOneView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct MissionOneView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @State private var isModalPresented = false
    @State private var isTutorialShown = true
    @State private var isFinished = false
    
    @State var tools: [Tool] = [
        Tool(localName: "AtukAntuk", bahasaName: "Palu", exampleAudioURL: "")]
    
    var body: some View {
        ZStack{
            if isTutorialShown {
                ZStack{
                    Rectangle()
        //                .foregroundStyle(.white)
                        .ignoresSafeArea()
                        .opacity(isTutorialShown ? 0.8 : 0)
                    Text("Ucapkan barang - \n barang yang ada di\n Daftar Belanja")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
                .animation(.easeIn(duration: 0.5), value: isTutorialShown)
                .zIndex(2)
            }
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 2.0)
            Image("Paper")
                .padding(.leading, 30)
            VStack{
                if(matchManager.isFinishedPlaying == 1 && isFinished == false){
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(width: 220, height: 54)
                        .foregroundStyle(.white)
                        .shadow(radius: 0, y: 5)
                        .overlay {
                            HStack{
                                Image(matchManager.otherCharacter!.headImage)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .padding(.bottom, 15)
                                Text("Hei lekaslah, aku sudah selesai")
                                    .font(.system(size: 15, weight: .bold))
                            }
                        }
    //                    .opacity(isModalPresented ? 1 : 0)
                        .animation(.linear, value: isModalPresented)
                }
                Spacer()
                Text("List Belanja")
                    .font(.system(size: 30, weight: .semibold))
                    .font(.title)
                    .padding(.bottom, 40)
                ForEach(tools) { tool in
                    textSound(textBahasa: tool.localName)
                }
                Spacer()
                ComponentButtonMic(textButton: "Tekan Untuk Bicara", iconButton: "mic.fill") {
                    print("Open Mic")
                    // KELAR MISSION ONE
                    isFinished = true
                    matchManager.isFinishedPlaying += 1
                    matchManager.synchronizeGameState("SoundMission")
                    if matchManager.isFinishedPlaying == 2 {
                        matchManager.gameStatus = .convoGudang
                    }
                    else{
                        isModalPresented = true
                    }
                }
                .padding(.bottom, 40)
            }

        }
        .blur(radius: isModalPresented ? 1 : 0)
        .sheet(isPresented: $isModalPresented) {
            ModalView()
                .presentationDetents([.height(190)])
        }
        .onTapGesture{
            isTutorialShown = false
        }
        .onAppear{
            tools = Array(matchManager.tools.shuffled().prefix(3))
        }
    }
}

//#Preview {
//    MissionOneView()
//        .environmentObject(MatchManager())
//}

struct textSound: View {
    @State var textBahasa : String
    var body: some View {
        HStack(spacing: 20){
            Button(action: {
                
            }, label: {
                Image(systemName: "speaker.wave.3.fill")
                    .resizable()
                    .frame(width: 30, height: 26)
            })
            Text(textBahasa)
                .font(.system(size: 23, weight: .semibold))
                .font(.title)
            Spacer()
        }
        .padding(.leading, 50)
    }
}

struct ModalView: View {
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            VStack{
                Text("Yeay Kamu berhasil membeli semua peralatan!")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                ComponentButtonMic(textButton: "Lanjutkan", iconButton: "") {
                }
            }
        }
    }
}
