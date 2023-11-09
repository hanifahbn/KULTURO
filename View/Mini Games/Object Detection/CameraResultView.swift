//
//  CameraPreview.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 25/10/23.
//

import SwiftUI

struct CameraResultView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @Binding var capturedImage: UIImage?
    @Binding var isSuccess: Bool
    
    
    var body: some View {
        ZStack{
            Image(uiImage: capturedImage!)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.5))
            
        } 
    }
}

