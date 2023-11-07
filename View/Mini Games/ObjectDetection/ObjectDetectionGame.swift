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
    @State var tool: Tool = ToolBrain().getFirstTool()
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
                VStack{
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
                                    Text(matchManager.timeInString)
                                        .font(.system(size: 19, weight: .bold))
                                }
                            })
                    }
                    .padding(.trailing, 30)
                    Spacer()
                }
            }
        }
        .sheet(isPresented: Binding(
            get: { matchManager.isTimerRunning == false },
            set: { _ in }
        )) {
            ModalView(modalType: "L ose")
                .environmentObject(matchManager)
                .presentationDetents([.height(190)])
        }
        .onAppear{
            matchManager.startTimer(time: 181)
            matchManager.isFinishedReading = 0
        }
    }
}

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
