//
//  MacroAppApp.swift
//  MacroApp
//
//  Created by Hanifah BN on 17/10/23.
//

import SwiftUI

@main
struct MacroApp: App {
    @ObservedObject var matchManager = MatchManager()
    var body: some Scene {
        WindowGroup {
//            ObjectDetectionGame()
            ContentView()
//            DesaStoriesView(viewModel: StoryViewModel())
//            GameStartView()
//            AyakPasirView()
//                .environmentObject(matchManager)
        }
    }
}
