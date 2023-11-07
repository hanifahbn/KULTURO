//
//  MissionOneView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct DummyView: View {
//    @EnvironmentObject var matchManager: MatchManager
    
    @State private var isModalPresented = false
    @State private var isTutorialShown = true
    @State private var isFinished = 0
    @State private var jumlahBenar = 0
    @StateObject var audioViewModel = AudioViewModel()
    @StateObject var playerViewModel = PlayerViewModel()
    @State var currentStep = 0
    @State var spoken = [false, false, false]
    @State var tools: [ToolBahasa] = [
        ToolBahasa(localName: "AtukAntuk", bahasaName: "Palu", labelName: "ApusapusNiPat", exampleAudioURL: ""),
        ToolBahasa(localName: "AtukAntuk", bahasaName: "Palu", labelName: "ApusapusNiPat", exampleAudioURL: ""),
        ToolBahasa(localName: "AtukAntuk", bahasaName: "Palu", labelName: "ApusapusNiPat", exampleAudioURL: "")]
    
    @State var textNamaTool : [String] = ["A"]
    @State var timerText: String = ""
    
    var body: some View {
        ZStack{
            if isTutorialShown {
                ZStack{
                    Rectangle()
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
            Image("BackgroundMisionOne")
                .resizable()
                .ignoresSafeArea()
            Image("Paper")
                .padding(.leading, 30)
            VStack{
                if(isFinished == 1){
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 220, height: 54)
                            .foregroundStyle(.white)
                            .shadow(radius: 0, y: 5)
                            .overlay {
                                HStack{
                                    Image("PersonTwo")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.bottom, 15)
                                    Text("Hei lekaslah, aku sudah selesai")
                                        .font(.system(size: 15, weight: .bold))
                                }
                            }
                            .animation(.linear, value: isFinished == 1)
                    }
                    .onAppear{
                        print("udah dipanggil nih")
                    }
                    .zIndex(3)
                }
                ZStack{
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
                                    Text("00:00")
                                        .font(.system(size: 19, weight: .bold))
                                }
                            })
                    }
                    .padding(.trailing, 30)
                }
                Spacer()
                Text("List Belanja")
                    .font(.system(size: 30, weight: .semibold))
                    .font(.title)
                    .padding(.bottom, 40)
                
                if textNamaTool.count > 2 {
                    TextKata(textBahasa: $textNamaTool[0])
                    TextKata(textBahasa: $textNamaTool[1])
                    TextKata(textBahasa: $textNamaTool[2])
                }

                Spacer()
                RecordButton(textButton: "Tekan Untuk Bicara", iconButton: "mic.fill", isWithIcon: true) {
                        if audioViewModel.audio.isRecording == false {
                            audioViewModel.startRecording()
                        }
                        else {
                        }
                    }
                .disabled(jumlahBenar == 3)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
        .onTapGesture{
            isTutorialShown = false
        }
        .onAppear{
            textNamaTool = tools.prefix(3).map { $0.localName }
        }
    }
}

#Preview {
    DummyView()
//        .environmentObject(MatchManager())
}
