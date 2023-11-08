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
    @State var isAllSuccess: Bool = false
    @State var isSuccess: Bool = false
    @State var isFailed: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false

    enum SheetType {
        case cameraSuccess
        case cameraSuccessAll
        case lose
    }
    
    var body: some View {
        ZStack{
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
                    ZStack{
                        CustomCameraView(capturedImage: $capturedImage, tool: $tool).ignoresSafeArea()
                    }
                }
            }
//            Group {
//                if currentSheet == .cameraSuccess {
//                    ZStack {
//                        ModalView(modalType: "CameraSuccess")
//                            .environmentObject(matchManager)
//                            .interactiveDismissDisabled()
//                            .frame(height: 190)
//                    }
//                } else if currentSheet == .cameraSuccessAll {
//                    ZStack {
//                        ModalView(modalType: "CameraSuccess")
//                            .environmentObject(matchManager)
//                            .interactiveDismissDisabled()
//                            .frame(height: 190)
//                    }
//                } else if currentSheet == .lose {
//                    ZStack {
//                        ModalView(modalType: "CameraSuccess")
//                            .environmentObject(matchManager)
//                            .interactiveDismissDisabled()
//                            .frame(height: 190)
//                    }
//                }
//            }
        }
        .onAppear{
            matchManager.startTimer(time: 5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isSuccess = true
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
//        .sheet(isPresented: $isSheetPresented) {
//            if currentSheet == .cameraSuccess {
//                ModalView(modalType: "CameraSuccess")
//                    .environmentObject(matchManager)
//                    .presentationDetents([.height(190)])
//            } else if currentSheet == .cameraSuccessAll {
//                ModalView(modalType: "CameraSuccess")
//                    .environmentObject(matchManager)
//                    .presentationDetents([.height(190)])
//            } else if currentSheet == .lose {
//                ModalView(modalType: "Lose")
//                    .environmentObject(matchManager)
//                    .presentationDetents([.height(190)])
//            }
//        }
        .sheet(isPresented:  $isSheetPresented) {
            ZStack {
                if currentSheet == .cameraSuccess {
                    ModalView(modalType: "CameraSuccess")
                        .environmentObject(matchManager)
                        .presentationDetents([.height(190)])
                } else if currentSheet == .cameraSuccessAll {
                    ModalView(modalType: "CameraSuccess")
                        .environmentObject(matchManager)
                        .presentationDetents([.height(190)])
                } else if currentSheet == .lose {
                    ModalView(modalType: "Lose")
                        .environmentObject(matchManager)
                        .presentationDetents([.height(190)])
                }
            }
            .presentationDetents([.height(190)])
        }
    }
    
    private func updateSheets() {
//        DispatchQueue.main.async {
            if isSuccess && matchManager.isTimerRunning {
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
//        }
    }
}

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
