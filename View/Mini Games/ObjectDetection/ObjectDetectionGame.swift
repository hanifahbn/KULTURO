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
        }
        .onAppear{
            matchManager.startTimer(time: 20)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                isSuccess = true
//            }
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
//                    ModalView(modalType: "Lose", backTo: .cameraGame)
//                        .environmentObject(matchManager)
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

    }
    
    private func updateSheets() {
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
    }
}

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
