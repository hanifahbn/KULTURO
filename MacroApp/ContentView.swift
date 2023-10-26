//
//  ContentView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 18/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var matchManager = MatchManager()
    var body: some View {
        Group{
            switch matchManager.gameStatus {
            case .setup:
                onBoardView()
                    .environmentObject(matchManager)
            case .inGame:
                InGameView()
                    .environmentObject(matchManager)
            case .gameOver:
                EndGameView()
            case .stories:
                StoryNaratorView(viewModel: StoryViewModel(), typingSpeed: 0)
            case .missionone:
                MissionOneView()
            }
        }.onAppear{
            matchManager.authenticateUser()
        }
    }
}
#Preview {
    ContentView()
}
