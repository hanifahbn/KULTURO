//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct InGameView: View {
    
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            ScrollView (.vertical){
                Button(action: {
                    
                }, label: {
                    TextSound(imageHalfBody: "KadesHalf", namaChar: "Pak Singa", asalChar: "Batak", colorBackground: "Coklat")
                })
                Button(action: {
                    
                }, label: {
                    TextSound(imageHalfBody: "Eyog", namaChar: "Eyog", asalChar: "Jawa", colorBackground: "HijauMudah")
                })
                Button(action: {
                    
                }, label: {
                    TextSound(imageHalfBody: "Gale", namaChar: "Oman", asalChar: "Bali", colorBackground: "Kuning")
                })
                Button(action: {
                    
                }, label: {
                    TextSound(imageHalfBody: "CiMei", namaChar: "Mei", asalChar: "Surabya", colorBackground: "BiruLangit")
                })
            }
            .padding()
        }
    }
}

#Preview {
    InGameView()
}

struct TextSound: View {
    @State var imageHalfBody : String
    @State var namaChar : String
    @State var asalChar : String
    @State var colorBackground : String
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(width: 348, height: 176)
            .foregroundStyle(Color(colorBackground))
            .overlay {
                HStack{
                    Image(imageHalfBody)
                        .resizable()
                        .frame(width: 195, height: 160)
                        .padding(.top)
                    VStack(alignment: .leading){
                        Text(namaChar)
                        Text(asalChar)
                    }
                    .foregroundStyle(.black)
                    .padding(.leading, -20)
                    .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
            }
    }
}
