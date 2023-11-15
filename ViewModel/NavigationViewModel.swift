////
////  NavigationViewModel.swift
////  MacroApp
////
////  Created by Irvan P. Saragi on 26/10/23.
////
//
//
import Foundation
import SwiftUI


class RouterViewStack: ObservableObject {
    
    @Published var path : [GameStatus] = []
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    func popToPage(page: GameStatus){
        if let index = path.firstIndex(of: page){
            path.removeLast(path.count - (index + 1))
        } else {
            print("Value not found in the array")
        }
    }
}


class ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destination: GameStatus) -> some View {
        @ObservedObject var matchManager = MatchManager()
        @ObservedObject var backsoundPlayer = PlayerViewModel()
        switch destination {
        case .setup:
            OnBoardView()
                .environmentObject(matchManager)
                .onAppear {
                    //                            router.clear()
                    matchManager.reset()
                    backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .inGame:
            InGameView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case.inMap:
            MapView()
        case .beginning:
            StoryNarratorView(narration: beginningNarration, nextGameStatus: .storyBalaiDesa)
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.playAudioLoop(fileName: "backsound", isLooping: true)
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .storyBalaiDesa:
            BalaiDesaView()
            //                .environmentObject(matchManager)
            //                .onAppear{
            //                    //                            router.clear()
            //                    backsoundPlayer.stopAudio()
            //                    //                           router.navigate(to: matchManager.gameStatus)
            //                }
            
        case .storyToko:
            TokoView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .soundGame:
            MissionOneView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .storyGudang:
            GudangView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .cameraGame:
            ObjectDetectionGame()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .storyPerbaikanBalaiDesaFirst:
            PerbaikanBalaiDesaView(stories: perbaikanStoriesFirst, nextGameStatus: .dragAndDrop)
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .dragAndDrop:
            DragDropView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .storyPerbaikanBalaiDesaSecond:
            PerbaikanBalaiDesaView(stories: perbaikanStoriesSecond, nextGameStatus: .shakeGame)
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .shakeGame:
            AyakPasirView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .storyBalaiDesaRenovated:
            BalaiDesaRenovatedView()
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.stopAudio()
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .ending:
            StoryNarratorView(narration: endingNarration, nextGameStatus: .setup)
                .environmentObject(matchManager)
                .onAppear{
                    //                            router.clear()
                    backsoundPlayer.playAudioLoop(fileName: "backsound")
                    //                           router.navigate(to: matchManager.gameStatus)
                }
        case .dummy:
            DummyView()
                .environmentObject(matchManager)
        }
        
    }
}
