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
        HStack(spacing: 20){
            Button(action: {
                playerViewModel.playAudio(fileName: textURL)
            }, label: {
                Image(systemName: "speaker.wave.3.fill")
                    .resizable()
                    .frame(width: 30, height: 26)
            })
            Text(textBahasa)
                .font(.system(size: 15, weight: .semibold))
                .font(.title)
            Spacer()
        }
        .padding(.leading, 70)
    }
}
