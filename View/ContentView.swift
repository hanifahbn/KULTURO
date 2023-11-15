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
                            //                            router.clear()
                            backsoundPlayer.stopAudio()
                            //                           router.navigate(to: matchManager.gameStatus)
                        }
                } else if matchManager.gameStatus == .cameraGame {
                    ObjectDetectionGame()
                        .environmentObject(matchManager)
                        .onAppear{
                            //                            router.clear()
                            backsoundPlayer.stopAudio()
                            //                           router.navigate(to: matchManager.gameStatus)
                        }
                } else if matchManager.gameStatus == .dragAndDrop {
                    DragDropView()
                        .environmentObject(matchManager)
                        .onAppear{
                            //                            router.clear()
                            backsoundPlayer.stopAudio()
                            //                           router.navigate(to: matchManager.gameStatus)
                        }
                } else if matchManager.gameStatus == .shakeGame {
                    AyakPasirView()
                        .environmentObject(matchManager)
                        .onAppear{
                            //                            router.clear()
                            backsoundPlayer.stopAudio()
                            //                           router.navigate(to: matchManager.gameStatus)
                        }
                }
            } else {
                
                Group{
                    ViewFactory.viewForDestination(matchManager.gameStatus)
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
