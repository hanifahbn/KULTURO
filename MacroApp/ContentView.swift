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
                OnBoardView()
                    .environmentObject(matchManager)
                    .onAppear {
                        matchManager.reset()
                    }
            case .inGame:
                InGameView()
                    .environmentObject(matchManager)
            case .gameOver:
                EndGameView()
            case .stories:
                StoryNaratorView(viewModel: StoryViewModel(), typingSpeed: 0.1)
                    .environmentObject(matchManager)
            case .isWaiting:
                WaitingRoomView()
            case .convoBalaiDesa:
                DesaStoriesView()
                    .environmentObject(matchManager)
            case .convoBeli:
                BeliStoriesView()
                    .environmentObject(matchManager)
            case .convoGudang:
                GudangStoriesView()
                    .environmentObject(matchManager)
            case .convoBantuDesa:
                BantuDesaView()
                    .environmentObject(matchManager)
            case .convoPasir:
                PasirStoriesView()
                    .environmentObject(matchManager)
            case .convoBerhasil:
                EndStoriesView()
                    .environmentObject(matchManager)
            case .missionone:
                MissionOneView()
                    .environmentObject(matchManager)
            }
        }.onAppear{
            matchManager.authenticateUser()
        }
    }
}
#Preview {
    ContentView()
}
