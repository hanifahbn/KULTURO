//
//  MissionOneView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct MissionOneView: View {
    @State private var isModalPresented = false
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 2.0)
            Image("Paper")
                .padding(.leading, 30)
            VStack{
                
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(width: 220, height: 54)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        HStack{
                            Image("PersonTwoHead")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .padding(.bottom, 15)
                            Text("Hei lekaslah, aku sudah selesai")
                                .font(.system(size: 15, weight: .bold))
                        }
                    }
                    .opacity(isModalPresented ? 1 : 0)
                    .animation(.linear, value: isModalPresented)
                
                
                Spacer()
                Text("List Belanja")
                    .font(.system(size: 30, weight: .semibold))
                    .font(.title)
                    .padding(.bottom, 40)
                textSound(textBahasa: "Sipadot")
                textSound(textBahasa: "Tel")
                textSound(textBahasa: "Jom Dinding")
                textSound(textBahasa: "Inganan Sampah")
                textSound(textBahasa: "Apusapus ni pat")
                Spacer()
                ComponetButtonMic(textButton: "Tekan Untuk Bicara", iconButton: "mic.fill") {
                    print("Open Mic")
                    isModalPresented.toggle()
                    
                }
                .padding(.bottom, 40)
            }

        }
        .blur(radius: isModalPresented ? 1 : 0)
        .sheet(isPresented: $isModalPresented) {
            ModalView()
                .presentationDetents([.height(190)])
        }
        
    }
}

#Preview {
    MissionOneView()
}

struct textSound: View {
    @State var textBahasa : String
    var body: some View {
        HStack(spacing: 20){
            Button(action: {
                
            }, label: {
                Image(systemName: "speaker.wave.3.fill")
                    .resizable()
                    .frame(width: 30, height: 26)
            })
            Text(textBahasa)
                .font(.system(size: 23, weight: .semibold))
                .font(.title)
            Spacer()
        }
        .padding(.leading, 50)
    }
}

struct ModalView: View {
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            VStack{
                Text("Yeay Kamu berhasil membeli semua peralatan!")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                ComponetButtonMic(textButton: "Lanjutkan", iconButton: "") {
                    print("Next Storie")
                }
            }
        }
    }
}
