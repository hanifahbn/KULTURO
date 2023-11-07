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
    @State var isSuccess: Bool = true


    var body: some View {
        ZStack{
           
            ZStack{
                if capturedImage != nil {
                    CameraResultView(capturedImage: $capturedImage, isSuccess: $isSuccess)
                        .environmentObject(matchManager)
                } else {
                    ZStack{
                        CustomCameraView(capturedImage: $capturedImage, tool: $tool).ignoresSafeArea()
                    }
                }

            }
        }
//        .sheet(isPresented: Binding(
//            get: { matchManager.isTimerRunning == false },
//            set: { _ in }
//        )) {
//            ModalView(modalType: "L ose")
//                .environmentObject(matchManager)
//                .presentationDetents([.height(190)])
//        }
//        .onAppear{
//            matchManager.startTimer(time: 181)
//            matchManager.isFinishedReading = 0
//        }
    }
}

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
