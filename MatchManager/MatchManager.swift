//
//  MatchManager.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import Foundation
import SwiftUI
import GameKit

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
    case stories
    case missionone
    case gameOver
}

class MatchManager: NSObject, ObservableObject{
    @Published var authStatus : UserAuthenticationState = .authenticated
    @Published var gameStatus : GameStatus = .setup
    
    var match : GKMatch?
    var localPlayer = GKLocalPlayer.local
    var otherPlayer: GKPlayer?
    var localCharacter: Karakter?
    var otherCharacter: Karakter?
    
    @Published var characters: [Karakter] = [
        Karakter(name: "Pak Singa", headImage: "", fullImage: "", halfImage: "KadesHalf", origin: "Batak", color: "Coklat", isChosen: false),
        Karakter(name: "Eyog", headImage: "", fullImage: "", halfImage: "Eyog", origin: "Jawa", color: "HijauMudah", isChosen: false),
        Karakter(name: "Oman", headImage: "", fullImage: "", halfImage: "Gale", origin: "Bali", color: "Kuning", isChosen: false),
        Karakter(name: "Mei", headImage: "", fullImage: "", halfImage: "CiMei", origin: "Surabaya", color: "BiruLangit", isChosen: false)
    ]
    
//    @Published var myAvatar = Image(systemName: "person.crop.circle")
//    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    
    let gameDuration = 15
    var otherPlayerScore: Int = 0
    var Score : Int = 0
    
    var rootViewController: UIViewController?{
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser(){
        GKLocalPlayer.local.authenticateHandler = { [self] vc, error in
            guard error == nil else {
//                print(error?.localizedDescription ?? "")
                authStatus = .error
                return
            }
            
            if GKLocalPlayer.local.isAuthenticated{
                authStatus = .authenticated
                self.localPlayer = GKLocalPlayer.local
//                print(self.localPlayer.displayName)
                
//                GKLocalPlayer.local.loadPhoto(for: GKPlayer.PhotoSize.small){ image, error in
//                    if let image {
//                        self.myAvatar = Image(uiImage: image)
//                    }
//                    if let error {
//                        // Handle an error if it occurs.
//                        print("Error: \(error.localizedDescription).")
//                    }
//                }
            } else {
                authStatus = .unauthenticated
            }
        }
    }
    
    func initiateMatch(){
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        
//        if let otherPlayer = match?.players.first {
//            self.otherPlayer = otherPlayer
//
//            self.otherPlayer?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
//                if let image {
//                    self.opponentAvatar = Image(uiImage: image)
//                }
//                if let error {
//                    print("Error: \(error.localizedDescription).")
//                }
//            }
//        }
//
//        // reset
//        Score = 0
//        otherPlayerScore = 0
        
        // back in game
        gameStatus = .inGame
    }
    
    func chooseCharacter(_ karakter: Karakter) {
        guard localCharacter == nil || otherCharacter == nil else {
            return
        }

        if localCharacter == nil {
            localCharacter = karakter
            if let index = characters.firstIndex(where: { $0.id == karakter.id }) {
                characters[index].isChosen = true
            }
            synchronizeCharacterSelection(karakter)
            
            if otherCharacter != nil {
                gameStatus = .stories
            }
        }
    }
    
//    func openLeaderboard() {
//        let gameCenterVC = GKGameCenterViewController(leaderboardID: "godsfingerleaderboard", playerScope: .global, timeScope: .today)
//        gameCenterVC.gameCenterDelegate = self
//        rootViewController?.present(gameCenterVC, animated: true)
//    }
//
//    func submitMyScoreToGameCenterLeaderboard(_ score: Int) {
//        GKLeaderboard.submitScore(score, context: 0, player: localPlayer, leaderboardIDs: ["godsfingerleaderboard"]) { [self] error in
//            guard error == nil else {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//
//            gameStatus = .gameOver
//        }
//    }
    
    func endGame(withScore score: Int) {
        Score = score
        
        // send data to other player
        sendString("playerScore:\(score)")
        
//        submitMyScoreToGameCenterLeaderboard(score)
    }
    
//    func updateOtherPlayerScore(withScore score: Int) {
//
//        otherPlayerScore = score
//
//    }
    
//    func receivedStringData(_ message: String) {
//        let messageSplit = message.split(separator: ":")
//
//        let score = Int(messageSplit.last ?? "0") ?? 0
//
//        updateOtherPlayerScore(withScore: score)
//    }

}
