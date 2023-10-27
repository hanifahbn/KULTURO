//
//  CameraPreview.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 25/10/23.
//

import SwiftUI

struct CameraResultView: View {

    @Binding var capturedImage: UIImage?
    @Binding var isSuccess: Bool
    
    
    var body: some View {
        ZStack{
            Image(uiImage: capturedImage!)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.5))
            
        } .sheet(isPresented: $isSuccess) {
            VStack {
                Text("Yeay Kamu berhasil menemukan semua perlengkapan!")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                ComponetButtonMic(textButton: "Lanjutkan", iconButton: "") {
                    print("Next Storie")
                }
            }
            .presentationDetents([.height(183)])
            .interactiveDismissDisabled()
            
        }
    }
}

