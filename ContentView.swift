//
//  ContentView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 18/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    var body: some View {
        Group{
            switch matchManager.gameStatus {
            case .setup:
                onBoardView(matchManager: matchManager)
            case .inGame:
                InGameView()
            case .gameOver:
                EndGameView()
            }
        }.onAppear{
            matchManager.authenticateUser()
        }
    }
}
#Preview {
    ContentView()
}
