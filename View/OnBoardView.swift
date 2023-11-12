//
//  onBoardView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct OnBoardView: View {
    @EnvironmentObject var matchManager : MatchManager
    
    var body: some View {
        ZStack{
            Image("BackgroundImageBoard")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Image("AppName")
                    .resizable()
                    .frame(width: 300, height: 150)
                
                    .padding(.bottom, 100)
                HStack{
                    Image(characters[1].fullImage)
                        .resizable()
                        .scaledToFit()
                    Image(characters[2].fullImage)
                        .resizable()
                        .scaledToFit()
                    Image(characters[4].fullImage)
                        .resizable()
                        .scaledToFit()
                    Image(characters[3].fullImage)
                        .resizable()
                        .scaledToFit()
                    Image(characters[0].fullImage)
                        .resizable()
                        .scaledToFit()
                }
                ComponentButton(textButton: "Start Game") {
                    matchManager.initiateMatch()
                }
            }
        }
    }
}

#Preview {
    OnBoardView()
        .environmentObject(MatchManager())
}
