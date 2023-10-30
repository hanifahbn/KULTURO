//
//  GameCenterViewModel.swift
//  MacroApp
//
//  Created by Hanifah BN on 24/10/23.
//

import Foundation
import GameKit

class GameCenterViewModel: NSObject, ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var playerName = ""

    var rootViewController: UIViewController?{
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        rootViewController?.dismiss(animated: true)
    }
    
    func authenticatePlayer() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let error = error {
                print("Game Center authentication error: \(error.localizedDescription)")
            } else if GKLocalPlayer.local.isAuthenticated {
                self.isAuthenticated = true
                self.playerName = GKLocalPlayer.local.displayName
            } else if let viewController = viewController {
                // Present the Game Center login view controller
                // You can present it modally, like a sheet, using SwiftUI's sheet modifier.
            }
        }
    }
}
