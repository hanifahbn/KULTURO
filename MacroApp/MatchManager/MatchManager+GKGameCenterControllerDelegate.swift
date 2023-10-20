//
//  MatchManager+GKGameCenterControllerDelegate.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import Foundation
import GameKit

extension MatchManager: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        rootViewController?.dismiss(animated: true)
    }
}
