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

    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    @State var tool: Tool = ToolBrain().getFirstTool()
    @State var isSuccess: Bool = true


    var body: some View {
        ZStack{
            if capturedImage != nil {
                CameraResultView(capturedImage: $capturedImage, isSuccess: $isSuccess)
            } else {

                ZStack{
                    CustomCameraView(capturedImage: $capturedImage, tool: $tool).ignoresSafeArea()
                }
            }

        }


    }
}

#Preview {
    ObjectDetectionGame()
}
