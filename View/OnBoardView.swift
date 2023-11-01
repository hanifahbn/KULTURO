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
            Image("BackgroundImage")
                .resizable()
                .blur(radius: 1.5)
                .ignoresSafeArea()
            VStack{
                Image("NamaApp")
                    .resizable()
                    .frame(width: 300, height: 150)
                
                    .padding(.bottom, 100)
                HStack{
                    Image("PersonOne")
                        .resizable()
                        .scaledToFit()
                    Image("HeadOffice")
                        .resizable()
                        .scaledToFit()
                    Image("PersonTwo")
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
