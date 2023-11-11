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
        ZStack {
            if matchManager.isRetrying {
                if matchManager.gameStatus == .soundGame {
                    MissionOneView()
                        .environmentObject(matchManager)
                        .onAppear{
                            backsoundPlayer.stopAudio()
                        }
                } else if matchManager.gameStatus == .cameraGame {
                    ObjectDetectionGame()
                        .environmentObject(matchManager)
                        .onAppear{
                            backsoundPlayer.stopAudio()
                        }
                } else if matchManager.gameStatus == .dragAndDrop {
                    DragDropView()
                        .environmentObject(matchManager)
                        .onAppear{
                            backsoundPlayer.stopAudio()
                        }
                } else if matchManager.gameStatus == .shakeGame {
                    AyakPasirView()
                        .environmentObject(matchManager)
                        .onAppear{
                            backsoundPlayer.stopAudio()
                        }
                }
            } else {
                Group{
                    switch matchManager.gameStatus {
                    case .setup:
                        OnBoardView()
                            .environmentObject(matchManager)
                            .onAppear {
                                matchManager.reset()
                                backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                            }
                    case .inGame:
                        InGameView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                            }
                    case .beginning:
                        StoryNarratorView(narration: beginningNarration, nextGameStatus: .storyBalaiDesa)
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                            }
                    case .storyBalaiDesa:
                        BalaiDesaView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                        
                    case .storyToko:
                        TokoView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .soundGame:
                        MissionOneView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
                            }
                    case .storyGudang:
                        GudangView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .cameraGame:
                        ObjectDetectionGame()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
                            }
                    case .storyPerbaikanBalaiDesaFirst:
                        PerbaikanBalaiDesaView(stories: perbaikanStoriesFirst, nextGameStatus: .dragAndDrop)
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .dragAndDrop:
                        DragDropView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
                            }
                    case .storyPerbaikanBalaiDesaSecond:
                        PerbaikanBalaiDesaView(stories: perbaikanStoriesSecond, nextGameStatus: .shakeGame)
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .shakeGame:
                        AyakPasirView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
                            }
                    case .storyBalaiDesaRenovated:
                        BalaiDesaRenovatedView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .ending:
                        StoryNarratorView(narration: endingNarration, nextGameStatus: .setup)
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .dummy:
                        DummyView()
                            .environmentObject(matchManager)
                    case .empty:
                        VStack {}
                    }
                }
            }
        }
        .onAppear{
            matchManager.authenticateUser()
        }
    }
}

#Preview {
    ContentView()
}
