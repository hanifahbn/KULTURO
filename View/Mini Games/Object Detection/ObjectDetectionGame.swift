//
//  ObjectDetectionGame.swift
//  MacroApp
//
//  Created by Auliya Michelle Adhana on 27/10/23.
//

import SwiftUI
import Vision
import AVFoundation

struct ObjectDetectionGame: View {
    @EnvironmentObject var matchManager: MatchManager

    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    @State var tool: Tool = ToolBrain().getRandomTool(nil)
    @State var isSuccess: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false
    @State private var isTutorialShown = false
    @State private var isSecondTutorial = false

    @State private var LightScale: CGFloat = 0.0

    enum SheetType {
        case cameraSuccess
        case cameraSuccessAll
        case lose
    }


    var body: some View {
        ZStack{
            GeometryReader { geo in
                if isTutorialShown {
                    ZStack{
                        Color.gray
                            .ignoresSafeArea()
                            .opacity(1)
                        VStack{
                            Spacer()
                            Text("Carilah barang yang diminta Pak Kades di sekitarmu, kemudian ambil gambarnya.")
                                .foregroundStyle(.white)
                                .font(.system(size: 38, weight: .bold, design: .rounded))
                                .padding(30)
                            HStack(spacing : -90){
                                Image("CameraTutorial")
                                Image("LightTutorial")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .padding(.bottom, 80)
                                    .opacity(LightScale)
                                    .animation(Animation.linear(duration: 1.0).repeatForever(), value: LightScale)
                                    .onAppear{
                                        LightScale = 1
                                    }
                            }
                            Spacer()
                        }

                    }
                    .animation(.easeIn(duration: 0.5), value: isTutorialShown)
                    .zIndex(2)
                }




//               if isSecondTutorial {
//                    ZStack{
//                        Color.blue
//                            .ignoresSafeArea()
//                            .opacity(0.5)
//
//                        VStack{
//                            Spacer()
//                            HStack{
//                                Spacer()
//                                Circle()
//                                    .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.47)
//                                    .blendMode(.destinationOut)
//                            }
//                        }
////                            .padding(.top, geo.size.height / 1.4)
////                            .padding(.leading, geo.size.width / 1.7)
//
//                    }
//                    .compositingGroup()
//                    .ignoresSafeArea()
//                    .zIndex(2)
//                }


                ZStack{
                    if capturedImage != nil {
                        CameraResultView(capturedImage: $capturedImage, isSuccess: $isSuccess)
                            .environmentObject(matchManager)
                            .onAppear{
                                isSuccess = true
                                matchManager.isFinishedPlaying += 1
                                matchManager.synchronizeGameState("CameraMission")
                            }
                    } else {

                        VStack{
                            HStack{
                                Spacer()
                                if(matchManager.isFinishedPlaying == 1 && !isSuccess){

                                    RoundedRectangle(cornerRadius: 15.0)
                                        .frame(width: 230, height: 54)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 0, y: 0)
                                        .overlay {
                                            HStack(){
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
                                    Spacer()
                                }

                                TimerView(countTo: 121)
                                    .environmentObject(matchManager)
                                    .padding(.trailing, matchManager.isFinishedPlaying == 1 && !isSuccess ?  0 : geo.size.width / 8)

                                if(matchManager.isFinishedPlaying == 1 && !isSuccess){
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        .zIndex(3)

                        ZStack{
                            CustomCameraView(capturedImage: $capturedImage, tool: $tool)
                        }
                    }
                }
            }
        }
        .onAppear{
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            matchManager.startTimer(time: 121)
            //            }
        }
        .onTapGesture{
            isTutorialShown = false
            isSecondTutorial = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isSecondTutorial = false
            }
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
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Color.ungu
                    .ignoresSafeArea()
                switch currentSheet {
                case .cameraSuccess:
                    ModalView(modalType: "CameraSuccess", textButton: "Menunggu temanmu selesai...")
                        .environmentObject(matchManager)
                case .cameraSuccessAll:
                    ModalView(modalType: "CameraSuccess", textButton: "Lanjutkan")
                        .environmentObject(matchManager)
                case .lose:
                    ModalView(modalType: "Lose", backTo: .cameraGame)
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

    }

    private func updateSheets() {
        if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying < 2 {
            currentSheet = .cameraSuccess
            isSheetPresented = true
        } else if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying == 2 {
            currentSheet = .cameraSuccessAll
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
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
