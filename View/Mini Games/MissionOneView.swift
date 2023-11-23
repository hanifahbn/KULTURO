//
//  MissionOneView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct MissionOneView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel = TransitionViewModel()
    @State private var isModalPresented = false
    @State private var isTutorialShown = true
    @State private var jumlahBenar = 0
    @StateObject var audioViewModel = AudioViewModel()
    @StateObject var playerViewModel = PlayerViewModel()
    @State var currentStep = 0
    @State var spoken = [false, false, false]
    @State var tools = toolList.compactMap { tool in
        tool.localName != nil ? tool: nil
    }
    @State var textNamaTool : [String] = ["A"]
    @State var isSuccess: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false
    @State private var isAnimating = false

    @State var textButton : String = "Tekan Untuk Bicara"
    @State var iconButton : String = "IconButtonSpeaker"
    @State var isWithIcon : Bool = true
    @State var buttonColor : String = "Kuning"
    @State var textColor : String = "Hitam"

    let hapticViewModel = HapticViewModel()

    enum SheetType {
        case soundSuccess
        case soundSuccessAll
        case lose
    }

    var body: some View {
        GeometryReader{ geometry in
        ZStack{
            if isTutorialShown {
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.8)
                    VStack{
                        Text("Ucapkan barang - \n barang yang ada di Daftar Belanja")
                            .foregroundStyle(.white)
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                        HStack{
                            Image("HeadSound")
                                .padding(.bottom, 60)
                            ZStack{
                                Image("Sound1")
                                    .padding(.trailing, 80)
                                    .padding(.top, 10)
                                    .opacity(isAnimating ? 1 : 0)
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0), value: isAnimating)

                                Image("Sound2")
                                    .padding(.trailing, 65)
                                    .padding(.top, 20)
                                    .opacity(isAnimating ? 1 : 0)
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.5), value: isAnimating)
                                Image("Sound3")
                                    .padding(.trailing, 50)
                                    .padding(.top, 30)
                                    .opacity(isAnimating ? 1 : 0)
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(1), value: isAnimating)
                                Image("Iphone")
                                    .padding(.trailing, -20)
                                    .padding(.top, 100)

                            }
                            .onAppear {
                                withAnimation {
                                    isAnimating = true
                                }
                            }
                            //                            .padding(.top, 120)
                        }
                        .padding(.leading, 50)
                        Text("*Carilah tempat yang tenang")
                            .foregroundStyle(.yellow)
                            .font(.custom("Chalkboard-Regular", size: 20))
                    }


                }
                .animation(.easeIn(duration: 0.5), value: isTutorialShown)
                .zIndex(2)
            }
            Image("BackgroundMisionOne")
                .resizable()
                .ignoresSafeArea()
            Image("Paper")
                .resizable()
                .frame(width: geometry.size.width - 20, height: geometry.size.height * 0.8)
            VStack{
                if(matchManager.isFinishedPlaying == 1 && !isSuccess){
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 220, height: 54)
                            .foregroundStyle(.white)
                            .opacity(0.5)
                            .shadow(radius: 0, y: 5)
                            .overlay {
                                HStack{
                                    Image(chosenCharacters[1].headImage)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.bottom, 15)
                                    Text("Hei, lekaslah! Aku sudah selesai.")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.black)
                                }
                            }
                            .animation(.linear, value: matchManager.isFinishedPlaying == 1)
                    }
                    .zIndex(3)
                }
                ZStack{
                    HStack{
                        Spacer()
                        TimerView(countTo: 46)
                            .environmentObject(matchManager)
                    }
                    .padding(.trailing, 30)
                }
//                Spacer()
                Text("Daftar Belanjaan")
                    .font(.custom("Chalkboard-Regular", size: 35))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .padding(.bottom, 90)
                    .padding(.top, 35)
                if textNamaTool.count > 2 {
                    VStack(spacing: 10){
                        TextKata(textBahasa: $textNamaTool[0], textURL: tools[0].exampleAudioURL!)
                        TextKata(textBahasa: $textNamaTool[1], textURL: tools[1].exampleAudioURL!)
                            .opacity(currentStep == 1 || currentStep == 2 || currentStep == 3 ? 1 : 0)
                        TextKata(textBahasa: $textNamaTool[2], textURL: tools[2].exampleAudioURL!)
                            .opacity(currentStep == 2 || currentStep == 3 ? 1 : 0)
                    }

                }

                Spacer()
                RecordButton(textButton: $textButton, isWithIcon: $isWithIcon, buttonColor: $buttonColor, textColor: $textColor) {
                    if audioViewModel.audio.isRecording == false {
                        audioViewModel.startRecording()
                        isWithIcon = false
                        buttonColor = "Kuning"
                        textColor = "Hitam"
                    }
                    else {
                        audioViewModel.stopRecording()
                        print("Label di view: \(audioViewModel.audio.label)")
                        if(audioViewModel.audio.label == tools[currentStep].labelName && spoken[currentStep] == false) {
                            textNamaTool[currentStep] = tools[currentStep].localName!.appending(" = ").appending(tools[currentStep].bahasaName)
                            playerViewModel.playAudio(fileName: "Correct")
                            hapticViewModel.simpleSuccess()
                            spoken[currentStep] = true
                            currentStep = currentStep + 1
                            jumlahBenar = jumlahBenar + 1
                            if(jumlahBenar == 3){
                            matchManager.isFinishedPlaying += 1
                            matchManager.synchronizeGameState("SoundMission")
                            isSuccess = true
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    hapticViewModel.simpleSuccess()
                                    playerViewModel.playAudio(fileName: tools[currentStep].exampleAudioURL!)
                                }
                                textButton = "Tekan Untuk Bicara"
                                isWithIcon = true
                                buttonColor = "Kuning"
                                textColor = "Hitam"
                            }
                        } else {
                            hapticViewModel.simpleError()
                            playerViewModel.playAudio(fileName: "Wrong")
                            textButton = "Tekan Untuk Mengulang"
                            isWithIcon = true
                            buttonColor = "DarkRed"
                            textColor = "AbuAbu"
                        }
                    }
                }
                //                }
                .disabled(jumlahBenar == 3)
                .padding(.bottom, 40)
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
            .interactiveDismissDisabled()
            .presentationDetents([.height(190)])
        }
        .onTapGesture{
            isTutorialShown = false
            playerViewModel.playAudio(fileName: tools[0].exampleAudioURL!)
        }
        .onAppear{
            tools = tools.shuffled()
            tools = Array(tools.prefix(3))
            textNamaTool = tools.prefix(3).map { $0.localName! }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                matchManager.startTimer(time: 46)
            }
        }
    }
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
