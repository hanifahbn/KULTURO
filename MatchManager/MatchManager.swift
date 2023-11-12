//
//  MatchManager.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import Foundation
import SwiftUI
import GameKit

class MatchManager: NSObject, ObservableObject{
    @Published var authStatus : UserAuthenticationState = .authenticated
    @Published var gameStatus : GameStatus = .setup
    @Published var isTimerRunning = false
    @Published var localPlayer = GKLocalPlayer.local
    @Published var otherPlayer: GKPlayer?
    @Published var localCharacter: Karakter?
    @Published var otherCharacter: Karakter?
    @Published var timer: Timer?
    @Published var timeInString: String = ""
    @Published var isRetrying: Bool = false
    
    var match : GKMatch?
    var isFinishedReading: Int = 0
    var isFinishedPlaying: Int = 0
    var localTools: [String]?
    var otherTools: [String]?
    
    @Published var tools: [ToolBahasa] = [
        ToolBahasa(localName: "Apusapus Ni Pat", bahasaName: "Keset", labelName:"ApusapusNiPat", exampleAudioURL: "ApusapusNiPat"),
        ToolBahasa(localName: "Sipadot", bahasaName: "Sapu", labelName:"Sipadot", exampleAudioURL: "Sipadot"),
        ToolBahasa(localName: "Tel", bahasaName: "Ember", labelName:"Tel", exampleAudioURL: "Tel"),
        ToolBahasa(localName: "Inganan Sampah", bahasaName: "Tempat Sampah", labelName:"IngananSampah", exampleAudioURL: "IngananSampah"),
        ToolBahasa(localName: "Jom Dinding", bahasaName: "Jam Dinding", labelName:"JomDinding", exampleAudioURL: "JomDinding"),
    ]
        
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
                authStatus = .error
                return
            }
            
            if GKLocalPlayer.local.isAuthenticated{
                authStatus = .authenticated
                self.localPlayer = GKLocalPlayer.local
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
        var remainingTime = time
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.updateTimer(remainingTime: &remainingTime)
        }
    }
    
    func updateTimer(remainingTime: inout Int) {
        if remainingTime > 0 {
            remainingTime -= 1
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            let timeString = String(format: "%02d:%02d", minutes, seconds)
            self.timeInString = timeString
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
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
            chosenCharacters[0] = localCharacter!
            if let index = characters.firstIndex(where: { $0.id == karakter.id }) {
                characters[index].isChosen = true
            }
            synchronizeCharacterSelection(karakter)
            
            if otherCharacter != nil {
                chosenCharacters[1] = otherCharacter!
//                synchronizeGameCharacters(chosenCharacters)
                gameStatus = .beginning
            }
        }
    }
        
    func endGame(withScore score: Int) {
        Score = score
        
        sendString("playerScore:\(score)")
    }
    

    
}
