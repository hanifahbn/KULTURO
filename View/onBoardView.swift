//
//  onBoardView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct onBoardView: View {
    @EnvironmentObject var matchManager : MatchManager
    
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text ("HeadTurner")
                    .font(.title)
                    .fontWeight(.semibold)
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
                .padding(.top, 200)//Sementara menunggu Judul Game
                ComponetButton(textButton: "Start Game") {
                    matchManager.initiateMatch()
                }
            }
        }
    }
}

#Preview {
    onBoardView()
        .environmentObject(MatchManager())
}
