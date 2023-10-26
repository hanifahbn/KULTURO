//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct InGameView: View {
    @EnvironmentObject var matchManager : MatchManager
    
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            ScrollView(.vertical) {
                ForEach(matchManager.characters) { karakter in
                    Button(action: {
                        matchManager.chooseCharacter(karakter)
                    }) {
                        TextSound(imageHalfBody: karakter.halfImage, namaChar: karakter.name, asalChar: karakter.origin, colorBackground: karakter.color)
                    }
                    .disabled(karakter.isChosen)
                    .opacity(karakter.isChosen ? 0.5 : 1.0)
                }
            }
            .padding()
        }
    }
}

#Preview {
    InGameView()
        .environmentObject(MatchManager())
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
