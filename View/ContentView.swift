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
                            backsoundPlayer.stopAudio()
                        }
                } else if matchManager.gameStatus == .cameraGame {
                    ObjectDetectionGame()
                        .environmentObject(matchManager)
                        .onAppear{
                            backsoundPlayer.stopAudio()
                        }
                } else if matchManager.gameStatus == .dragAndDrop {
                    DragDropMultiView()
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
                                matchManager.stopMonitoringConnection()
                                matchManager.reset()
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .inGame:
                        InGameView()
                            .environmentObject(matchManager)
                            .onAppear{
                                matchManager.startMonitoringConnection()
                            }
                    case .inMap:
                        MapView()
                            .environmentObject(matchManager)
                            .onAppear{
                            }
                    case .beginning:
                        StoryNarratorView(narration: beginningNarration, nextGameStatus: .storyBalaiDesa)
                            .environmentObject(matchManager)
                            .onAppear{
                            }
                    case .storyBalaiDesa:
                        BalaiDesaView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
                            }
                        
                    case .storyToko:
                        TokoView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
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
                                backsoundPlayer.stopAudio()
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
                                backsoundPlayer.stopAudio()
                            }
                    case .dragAndDrop:
                        DragDropMultiView()
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
                            }
                    case .storyPerbaikanBalaiDesaSecond:
                        PerbaikanBalaiDesaView(stories: perbaikanStoriesSecond, nextGameStatus: .shakeGame)
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.stopAudio()
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
                                matchManager.stopMonitoringConnection()
                                backsoundPlayer.stopAudio()
                            }
                    case .ending:
                        StoryNarratorView(narration: endingNarration, nextGameStatus: .setup)
                            .environmentObject(matchManager)
                            .onAppear{
                                backsoundPlayer.playAudioLoop(fileName: "backsound")
                            }
                    case .error:
                        ErrorHandlingView()
                            .environmentObject(matchManager)
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
