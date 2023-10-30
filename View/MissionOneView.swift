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
                                    Image(matchManager.otherCharacter!.headImage)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.bottom, 15)
                                    Text("Hei lekaslah, aku sudah selesai")
                                        .font(.system(size: 15, weight: .bold))
                                }
                            }
        //                    .opacity(isModalPresented ? 1 : 0)
                            .animation(.linear, value: isFinished == 1)
                    }
                    .onAppear{
                        print("udah dipanggil nih")
                    }
                    .zIndex(3)
                }
                Spacer()
                Text("List Belanja")
                    .font(.system(size: 30, weight: .semibold))
                    .font(.title)
                    .padding(.bottom, 40)
                
                if textNamaTool.count > 2 {
                    textSound(textBahasa: $textNamaTool[0])
                    textSound(textBahasa: $textNamaTool[1])
                    textSound(textBahasa: $textNamaTool[2])
                }

                Spacer()
                RecordButton(textButton: "Tekan Untuk Bicara", iconButton: "mic.fill") {
                    if(jumlahBenar == 3){
                        matchManager.isFinishedPlaying += 1
                        matchManager.synchronizeGameState("SoundMission")
                        if matchManager.isFinishedPlaying == 2 {
                            isModalPresented = true
                        }
                        else{
                            isModalPresented = true
                        }
                    }
                    else{
                        if audioViewModel.audio.isRecording == false {
                            audioViewModel.startRecording()
                        }
                        else {
                            audioViewModel.stopRecording()
                            print("Label di view: \(audioViewModel.audio.label)")
                            if(audioViewModel.audio.label == tools[currentStep].labelName && spoken[currentStep] == false) {
                                print("BENER")
                                textNamaTool[currentStep] = tools[currentStep].localName.appending(" = ").appending(tools[currentStep].bahasaName)
                                playerViewModel.playAudio(fileName: "Correct")
                                spoken[currentStep] = true
                                currentStep = currentStep + 1
                            }
                        }
                    }
                }
                .disabled(jumlahBenar == 3)
                .padding(.bottom, 40)
                .onAppear{
                    isFinished = matchManager.isFinishedPlaying
                }
            }

        }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
        .sheet(isPresented: Binding(
            get: { matchManager.isTimerRunning == true && isModalPresented },
            set: { _ in }
        )) {
            ModalView()
                .environmentObject(matchManager)
                .presentationDetents([.height(190)])
                .onAppear{
                    print("Yang udah kelar: \(matchManager.isFinishedPlaying)")
                }
        }
        .sheet(isPresented: Binding(
            get: { matchManager.isTimerRunning == false },
            set: { _ in }
        )) {
            ModalView(modalType: "Lose")
                .environmentObject(matchManager)
                .presentationDetents([.height(190)])
        }
        .onTapGesture{
            isTutorialShown = false
        }
        .onAppear{
            matchManager.isFinishedReading = 0
            tools = Array(matchManager.tools.shuffled().prefix(3))
            textNamaTool = tools.prefix(3).map { $0.localName }
            matchManager.isTimerRunning = true
            matchManager.startTimer(time: 60)
            print(textNamaTool)
        }
    }
}

//#Preview {
//    MissionOneView()
//        .environmentObject(MatchManager())
//}

struct textSound: View {
    @Binding var textBahasa : String
    var body: some View {
        HStack(spacing: 20){
            Button(action: {
                
            }, label: {
                Image(systemName: "speaker.wave.3.fill")
                    .resizable()
                    .frame(width: 30, height: 26)
            })
            Text(textBahasa)
                .font(.system(size: 15, weight: .semibold))
                .font(.title)
            Spacer()
        }
        .padding(.leading, 50)
    }
}
