//
//  TextKata.swift
//  MacroApp
//
//  Created by Hanifah BN on 07/11/23.
//

import SwiftUI

struct TextKata: View {
    @Binding var textBahasa : String
    @State var textURL : String
    @StateObject var playerViewModel = PlayerViewModel()
    var body: some View {
        HStack(spacing: 5){
            Button(action: {
                playerViewModel.playAudio(fileName: textURL)
            }, label: {
                Image("IconButtonSpeaker")
//                    .resizable()
//                    .frame(width: 30, height: 26)
            })
            if let splitText = textBahasa.components(separatedBy: " = ") as? [String], splitText.count == 2 {
                HStack {
                    Text(splitText[0])
                        .foregroundStyle(.black)
                        .font(.custom("Chalkboard-Regular", size: 27))
                        .fontWeight(.semibold)
                        .font(.title)

                    Text("=")
                        .foregroundStyle(.black )
                        .font(.custom("Chalkboard-Regular", size: 27))
                        .fontWeight(.semibold)
                        .font(.title)
                    
                    Text(splitText[1])
                        .foregroundStyle(Color.darkRed)
                        .font(.custom("Chalkboard-Regular", size: 27))
                        .fontWeight(.semibold)
                        .font(.title)
                }
            } else {
                Text(textBahasa)
                    .foregroundStyle(.black)
                    .font(.custom("Chalkboard-Regular", size: 27))
                    .fontWeight(.semibold)
                    .font(.title)
            }
            Spacer()
        }
        .padding(.leading, 70)
        .padding(.trailing, 50)
    }
}
