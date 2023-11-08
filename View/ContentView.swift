//
//  ContentView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 18/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var matchManager = MatchManager()
    @ObservedObject var backsoundPlayer = PlayerViewModel()
    
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
            case .beginning:
                StoryNarratorView(narration: beginningNarration, nextGameStatus: .storyGapura)
                    .environmentObject(matchManager)
            case .storyGapura:
                GapuraView()
                    .environmentObject(matchManager)
            case .storyBalaiDesa:
                BalaiDesaView()
                    .environmentObject(matchManager)
            case .storyToko:
                TokoView()
                    .environmentObject(matchManager)
            case .soundGame:
                MissionOneView()
                    .environmentObject(matchManager)
            case .storyGudang:
                GudangView()
                    .environmentObject(matchManager)
            case .cameraGame:
                ObjectDetectionGame()
                    .environmentObject(matchManager)
            case .storyPerbaikanBalaiDesaFirst:
                PerbaikanBalaiDesaView(stories: perbaikanStoriesFirst, nextGameStatus: .dragAndDrop)
                    .environmentObject(matchManager)
            case .dragAndDrop:
                DragDropView()
                    .environmentObject(matchManager)
            case .storyPerbaikanBalaiDesaSecond:
                PerbaikanBalaiDesaView(stories: perbaikanStoriesSecond, nextGameStatus: .shakeGame)
                    .environmentObject(matchManager)
            case .shakeGame:
                AyakPasirView()
                    .environmentObject(matchManager)
            case .storyBalaiDesaRenovated:
                BalaiDesaRenovatedView()
                    .environmentObject(matchManager)
            case .ending:
                StoryNarratorView(narration: endingNarration, nextGameStatus: .setup)
                    .environmentObject(matchManager)
            case .empty:
                VStack {
                }
            }
        }
        .onAppear{
            matchManager.authenticateUser()
            backsoundPlayer.playAudioLoop(fileName: "backsound")
        }
    }
}

#Preview {
    ContentView()
}
