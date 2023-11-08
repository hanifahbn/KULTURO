//
//  Enums.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import Foundation

enum UserAuthenticationState: String {
    case authenticating = "Logging to Game Center..."
    case authenticated = "Good to go!"
    case unauthenticated = "Please sign in to Game Center!"
    case error = "There was an error logging to Game Center."
    case restricted = "You're restricted to play game."
}

enum GameStatus {
    case setup
    case inGame
    case beginning
    case storyGapura
    case storyBalaiDesa
    case storyToko
    case soundGame
    case storyGudang
    case cameraGame
    case storyPerbaikanBalaiDesaFirst
    case dragAndDrop
    case storyPerbaikanBalaiDesaSecond
    case shakeGame
    case storyBalaiDesaRenovated
    case ending
}
