//
//  MatchManager.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import Foundation
import SwiftUI
import GameKit
import AVFoundation
import Network

class MatchManager: NSObject, ObservableObject{
    @Published var authStatus : UserAuthenticationState = .authenticated
    @Published var gameStatus : GameStatus = .setup
    @Published var errorType : ErrorTypes = .none
    @Published var isTimerRunning = false
    @Published var localPlayer = GKLocalPlayer.local
    @Published var otherPlayer: GKPlayer?
    @Published var localCharacter: Karakter?
    @Published var otherCharacter: Karakter?
    @Published var timer: Timer?
    @Published var timeInString: String = ""
    @Published var isRetrying: Bool = false
    
    var isPlayerSpeaking = false
    var match : GKMatch?
    var isFinishedReading: Int = 0
    var isFinishedPlaying: Int = 0
    var localTools: [String]?
    var otherTools: [String]?
    var voiceChat: GKVoiceChat?
    
    private let monitor = NWPathMonitor()
    private var isMonitoringConnection = false
    
    var matchToolList = toolList.compactMap { tool in
        tool.image != nil ? tool: nil
    }
    
    @Published var itemsToDrag: [ToolBahasa] = [ToolBahasa(bahasaName: "Tisu", image: "Tisu", width: 60, height: 60)]
    
    @Published var itemsToCollect: [String] = [""]
    
    override init() {
        super.init()
    }
    
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
        
        itemsToDrag = [ToolBahasa(bahasaName: "Tisu", image: "Tisu", width: 60, height: 60)]
        
        itemsToCollect = [""]

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
                gameStatus = .inMap
            }
        }
    }
     
    func startVoiceChat() {
//        do {
//            let audioSession = AVAudioSession.sharedInstance()
//
//            try audioSession.setCategory(.playAndRecord, mode: AVAudioSession.Mode.gameChat, options: .interruptSpokenAudioAndMixWithOthers)
//            
//            try audioSession.setActive(true, options: [])
//        }
//        catch {
//            return
//        }
        
        do {
            let audioSession = AVAudioSession.sharedInstance()


            try audioSession.setActive(true, options: [])
        }
        catch {
            return
        }
        
        voiceChat = match?.voiceChat(withName: "DragAndDropChannel")
        voiceChat?.start()
        voiceChat?.volume = 1.0
        voiceChat?.isActive = true
        
        print("\(String(describing: voiceChat?.players))")
    }
    
    func joinVoiceChat() {
//        do {
//            let audioSession = AVAudioSession.sharedInstance()
//
//
//            try audioSession.setActive(true, options: [])
//        }
//        catch {
//            return
//        }
//        
        voiceChat = match?.voiceChat(withName: "DragAndDropChannel")
        voiceChat?.start()
//        voiceChat?.isActive = true
        // SAMPE SINI BERHASIL
        
//        voiceChat?.volume = 1.0
        
//        voiceChat?.isActive = true
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            self.voiceChat?.isActive = false
//        }
    }

    func stopVoiceChat(){
        voiceChat?.stop()
        voiceChat = nil
        
        do {
            let audioSession = AVAudioSession.sharedInstance()


            try audioSession.setActive(false, options: [])
        }
        catch {
            return
        }
    }
    
    func startMonitoringConnection() {
        guard !isMonitoringConnection else { return }
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status != .satisfied {
                    self?.gameStatus = .error
                    self?.errorType = .noConnection
                }
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        isMonitoringConnection = true
    }

    func stopMonitoringConnection() {
        if isMonitoringConnection {
            monitor.cancel()
            isMonitoringConnection = false
        }
    }
}
