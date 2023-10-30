//
//  GameStartView.swift
//  MacroApp
//
//  Created by Hanifah BN on 24/10/23.
//

import SwiftUI

struct GameStartView: View {
    @StateObject var gameCenterViewModel = GameCenterViewModel()
    var body: some View {
        VStack{
            Text("Hello, \(gameCenterViewModel.playerName)")
            CharacterChoosingView()
        }
        .onAppear{
            gameCenterViewModel.authenticatePlayer()
        }
    }
}

#Preview {
    GameStartView()
}
