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
    case isWaiting
    case cameraGame
    case dragAndDrop
    case convoBalaiDesa
    case convoBeli
    case convoGudang
    case convoBantuDesa
    case convoPasir
    case convoBerhasil
}

class MatchManager: NSObject, ObservableObject{
    @Published var authStatus : UserAuthenticationState = .authenticated
    @Published var gameStatus : GameStatus = .setup
    @Published var isTimerRunning = false
    @Published var localPlayer = GKLocalPlayer.local
    @Published var otherPlayer: GKPlayer?
    @Published var localCharacter: Karakter?
    @Published var otherCharacter: Karakter?
    
    var match : GKMatch?
    var isFinishedReading: Int = 0
    var isFinishedPlaying: Int = 0
    var localTools: [String]?
    var otherTools: [String]?
    
    @Published var characters: [Karakter] = [
        Karakter(name: "Dayu", headImage: "Dayu", fullImage: "", halfImage: "", origin: "Bali", colorRight: "GkananKuning", colorLeft: "GkiriKuning", isChosen: false),
        Karakter(name: "Togar", headImage: "Eyog", fullImage: "", halfImage: "", origin: "Medan", colorRight: "GkananHijau", colorLeft: "GkiriHijau", isChosen: false),
        Karakter(name: "Asep", headImage: "Gale", fullImage: "", halfImage: "", origin: "Bandung", colorRight: "GkananBiru", colorLeft: "GkiriBiru", isChosen: false),
        Karakter(name: "Ajeng", headImage: "Ajeng", fullImage: "", halfImage: "", origin: "Bali", colorRight: "GkananUngu", colorLeft: "GkiriUngu", isChosen: false),
    ]
    
    @Published var tools: [ToolBahasa] = [
        ToolBahasa(localName: "Apusapus Ni Pat", bahasaName: "Keset", labelName:"ApusapusNiPat", exampleAudioURL: ""),
        ToolBahasa(localName: "Sipadot", bahasaName: "Sapu", labelName:"Sipadot", exampleAudioURL: ""),
        ToolBahasa(localName: "Tel", bahasaName: "Ember", labelName:"Tel", exampleAudioURL: ""),
        ToolBahasa(localName: "Inganan Sampah", bahasaName: "Tempat Sampah", labelName:"IngananSampah", exampleAudioURL: ""),
        ToolBahasa(localName: "Jom Dinding", bahasaName: "Jam Dinding", labelName:"JomDinding", exampleAudioURL: ""),
    ]
    
//    @Published var myAvatar = Image(systemName: "person.crop.circle")
//    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    
    @Published var choosenCharacters: [Karakter]? = []
        
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
    
    func reset(){
        isTimerRunning = false
        localPlayer = GKLocalPlayer.local
        otherPlayer = nil
        localCharacter = nil
        otherCharacter = nil
        
        match = nil
        isFinishedReading = 0
        isFinishedPlaying = 0
        localTools = nil
        otherTools = nil
        
        for (index, _) in characters.enumerated() {
            characters[index].isChosen = false
        }
    }
    
    func startTimer(time: Int) {
       isTimerRunning = true
       DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(Int(time))) {
           self.isTimerRunning = false
       }
   }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        
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
                choosenCharacters?.append(localCharacter!)
                choosenCharacters?.append(otherCharacter!)
                synchronizeGameCharacters(choosenCharacters!)
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
