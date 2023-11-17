//
//  MatchManager+GKMatchDelegate.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import Foundation
import GameKit

extension MatchManager: GKMatchDelegate{
    func match(_ match: GKMatch, didChange state: GKPlayerConnectionState, for player: GKPlayer) {
        switch state {
        case .connected:
            print("Player \(player.displayName) is connected.")
        case .disconnected:
            print("Player \(player.displayName) is disconnected.")
        case .unknown:
            print("Player \(player.displayName) connection status is unknown.")
        @unknown default:
            break
        }
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
        if let receivedCharacter = try? JSONDecoder().decode(Karakter.self, from: data) {
            if let index = characters.firstIndex(where: { $0.name == receivedCharacter.name }) {
                characters[index].isChosen!.toggle()
                otherCharacter = characters[index]
                
//                joinVoiceChat()
                
                if localCharacter != nil {
                    chosenCharacters[1] = otherCharacter!
//                    synchronizeGameCharacters(chosenCharacters)
                    gameStatus = .beginning
                }
            }
        } else {
            print("Failed to decode received data as Karakter.")
        }
        
        if let receivedGameCharacters = try? JSONDecoder().decode([Karakter].self, from: data) {
            // Mengganti karakter lokal dengan karakter yang diterima
            chosenCharacters = receivedGameCharacters
        } else {
            print("Failed to decode received data as Kumpulan Karakter.")
        }
        
        if let receivedState = try? String(decoding: data, as: UTF8.self) {
            handleReceivedState(receivedState)
        } else {
            print("Failed to decode received data as a String.")
        }
    }
    
    func handleReceivedState(_ state: String){
        if state == "Reading" {
            isFinishedReading += 1
            if(isFinishedReading == 2){
                gameStatus = .soundGame
                isFinishedReading = 0
            }
        }
        if state == "ReadingSecond" {
            isFinishedReading += 1
            if(isFinishedReading == 2){
                gameStatus = .cameraGame
                isFinishedReading = 0
            }
        }
        if state == "ReadingThird" {
            isFinishedReading += 1
            if(isFinishedReading == 2){
                gameStatus = .dragAndDrop
                isFinishedReading = 0
            }
        }
        if state == "ReadingFourth" {
            isFinishedReading += 1
            if(isFinishedReading == 2){
                gameStatus = .shakeGame
                isFinishedReading = 0
            }
        }
        if state == "SoundMission" || state == "CameraMission"
            || state == "DragAndDropMission" || state == "AyakPasirMission"{
            isFinishedPlaying += 1
        }
    }
    
    func sendString(_ message: String ) {
        guard let encodedString = "playerScore:\(message)".data(using: .utf8) else { return }
        sendData(encodedString, mode: .reliable)
    }
    
    func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
        do {
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch {
            print("SENDING DATA ERROR: \(error.localizedDescription)")
        }
    }
    
}
