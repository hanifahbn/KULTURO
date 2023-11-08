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
    @State var isSuccess: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false
    
    enum SheetType {
        case soundSuccess
        case soundSuccessAll
        case lose
    }
    
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
                ZStack{
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
                    .padding(.trailing, 30)
                }
                Spacer()
                Text("List Belanja")
                    .font(.system(size: 30, weight: .semibold))
                    .font(.title)
                    .padding(.bottom, 40)
                
                if textNamaTool.count > 2 {
                    TextKata(textBahasa: $textNamaTool[0], textURL: tools[0].exampleAudioURL)
                    TextKata(textBahasa: $textNamaTool[1], textURL: tools[1].exampleAudioURL)
                        .opacity(currentStep == 1 ? 0 : 1)
                    TextKata(textBahasa: $textNamaTool[2], textURL: tools[2].exampleAudioURL)
                        .opacity(currentStep == 2 ? 0 : 1)
                }

                Spacer()
                RecordButton(textButton: "Tekan Untuk Bicara", iconButton: "mic.fill") {
                        if audioViewModel.audio.isRecording == false {
                            audioViewModel.startRecording()
                        }
                        else {
                            audioViewModel.stopRecording()
//                            print("Label di view: \(audioViewModel.audio.label)")
//                            if(audioViewModel.audio.label == tools[currentStep].labelName && spoken[currentStep] == false) {
                                textNamaTool[currentStep] = tools[currentStep].localName.appending(" = ").appending(tools[currentStep].bahasaName)
                                playerViewModel.playAudio(fileName: "Correct")
                                spoken[currentStep] = true
                                currentStep = currentStep + 1
                                jumlahBenar = jumlahBenar + 1
                                if(jumlahBenar == 3){
                                    matchManager.isFinishedPlaying += 1
                                    matchManager.synchronizeGameState("SoundMission")
                                    isSuccess = true
                                }
//                            }
                        }
                    }
//                }
                .disabled(jumlahBenar == 3)
                .padding(.bottom, 40)
                .onAppear{
                    isFinished = matchManager.isFinishedPlaying
                }
                .onChange(of: isSuccess) { _ in
                    updateSheets()
                }
                .onChange(of: matchManager.isTimerRunning) { _ in
                    updateSheets()
                }
                .onChange(of: matchManager.isFinishedPlaying) { _ in
                    updateSheets()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .blur(radius: isModalPresented ? 1 : 0)
//        .sheet(isPresented: Binding(
//            get: { matchManager.isTimerRunning == true && isModalPresented },
//            set: { _ in }
//        )) {
//            ModalView(modalType: "SoundSuccess")
//                .environmentObject(matchManager)
//                .presentationDetents([.height(190)])
//        }
//        .sheet(isPresented: Binding(
//            get: { matchManager.isTimerRunning == false && jumlahBenar < 3 },
//            set: { _ in }
//        )) {
//            ModalView(modalType: "Lose")
//                .environmentObject(matchManager)
//                .presentationDetents([.height(190)])
//        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Color.ungu
                    .ignoresSafeArea()
                switch currentSheet {
                case .soundSuccess:
                    ModalView(modalType: "SoundSuccess", textButton: "Menunggu temanmu selesai...")
                        .environmentObject(matchManager)
                case .soundSuccessAll:
                    ModalView(modalType: "SoundSuccess", textButton: "Lanjutkan")
                        .environmentObject(matchManager)
                case .lose:
                    ModalView(modalType: "Lose", backTo: .soundGame)
                        .environmentObject(matchManager)
                case .none:
                    VStack {
                        EmptyView()
                    }
                    .onAppear{
                        isSuccess.toggle()
                        isSuccess.toggle()
                    }
                }
            }
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
            matchManager.startTimer(time: 46)        }
    }
    
    private func updateSheets() {
        if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying < 2 {
            currentSheet = .soundSuccess
            isSheetPresented = true
        } else if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying == 2 {
            currentSheet = .soundSuccessAll
            isSheetPresented = true
        } else if isSuccess && !matchManager.isTimerRunning && matchManager.isFinishedPlaying < 2 {
            currentSheet = .lose
            isSheetPresented = true
        } else if !isSuccess && !matchManager.isTimerRunning {
            currentSheet = .lose
            isSheetPresented = true
        }
    }
}

#Preview {
    MissionOneView()
        .environmentObject(MatchManager())
}
