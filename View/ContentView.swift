//
//  ContentView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 18/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var matchManager = MatchManager()
    @ObservedObject var router = RouterViewModel()
    @ObservedObject var backsoundPlayer = PlayerViewModel()
    
    var body: some View {
        ZStack {
            if matchManager.isRetrying {
                if matchManager.gameStatus == .soundGame {
                    MissionOneView()
                        .environmentObject(matchManager)
                        .onAppear{
                            router.clear()
                            backsoundPlayer.stopAudio()
                            router.navigate(to: matchManager.gameStatus)
                        }
                } else if matchManager.gameStatus == .cameraGame {
                    ObjectDetectionGame()
                        .environmentObject(matchManager)
                        .onAppear{
                            router.clear()
                            backsoundPlayer.stopAudio()
                            router.navigate(to: matchManager.gameStatus)
                        }
                } else if matchManager.gameStatus == .dragAndDrop {
                    DragDropView()
                        .environmentObject(matchManager)
                        .onAppear{
                            router.clear()
                            backsoundPlayer.stopAudio()
                            router.navigate(to: matchManager.gameStatus)
                        }
                } else if matchManager.gameStatus == .shakeGame {
                    AyakPasirView()
                        .environmentObject(matchManager)
                        .onAppear{
                            router.clear()
                            backsoundPlayer.stopAudio()
                            router.navigate(to: matchManager.gameStatus)
                        }
                }
            } else {
                Group{
                    switch matchManager.gameStatus {
                    case .setup:
                        OnBoardView()
                            .environmentObject(matchManager)
                            .onAppear {
                                router.clear()
                                matchManager.reset()
                                backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .inGame:
                        InGameView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .beginning:
                        StoryNarratorView(narration: beginningNarration, nextGameStatus: .storyBalaiDesa)
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .storyBalaiDesa:
                        BalaiDesaView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                        
                    case .storyToko:
                        TokoView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .soundGame:
                        MissionOneView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.stopAudio()
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .storyGudang:
                        GudangView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .cameraGame:
                        ObjectDetectionGame()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.stopAudio()
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .storyPerbaikanBalaiDesaFirst:
                        PerbaikanBalaiDesaView(stories: perbaikanStoriesFirst, nextGameStatus: .dragAndDrop)
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .dragAndDrop:
                        DragDropView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.stopAudio()
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .storyPerbaikanBalaiDesaSecond:
                        PerbaikanBalaiDesaView(stories: perbaikanStoriesSecond, nextGameStatus: .shakeGame)
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .shakeGame:
                        AyakPasirView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.stopAudio()
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .storyBalaiDesaRenovated:
                        BalaiDesaRenovatedView()
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .ending:
                        StoryNarratorView(narration: endingNarration, nextGameStatus: .setup)
                            .environmentObject(matchManager)
                            .onAppear{
                                router.clear()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                                router.navigate(to: matchManager.gameStatus)
                            }
                    case .dummy:
                        DummyView()
                            .environmentObject(matchManager)
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
