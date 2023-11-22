//
//  MatchManager+GKMatchDelegate.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import Foundation
import GameKit

extension MatchManager: GKMatchDelegate{
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        print("Player \(player.displayName) changed state: \(state.rawValue)") // Debug print
        switch state {
        case .connected:
            print("Player \(player.displayName) is connected.")
        case .disconnected:
            print("Player \(player.displayName) is disconnected.")
            gameStatus = .error
            errorType = .friendDisconnected
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
                    gameStatus = .inMap
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
            if receivedState == "ACTIVATE" {
                joinVoiceChat()
            } else if receivedState == "DEACTIVATE" {
                stopVoiceChat()
            }
            else {
                handleReceivedState(receivedState)
            }
        } else {
            print("Failed to decode received data as a String.")
        }
        
        if let receivedItems = try? JSONDecoder().decode([ToolBahasa].self, from: data) {
            itemsToDrag = receivedItems
        } else {
            print("Failed to decode received data as Tools.")
        }
        
        if let receivedTool = try? JSONDecoder().decode(ToolBahasa.self, from: data) {
            itemsToDrag.append(receivedTool)
        } else {
            print("Failed to decode received data as Karakter.")
        }
        
        if let receivedItemsToCollect = try? JSONDecoder().decode([String].self, from: data) {
            itemsToCollect = receivedItemsToCollect
        } else {
            print("Gagal mendecode data yang diterima menjadi array of string.")
        }
    }
    
    func handleReceivedState(_ state: String){
        if state == "BEGIN GAME TOBA" {
            gameStatus = .beginning
        }
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
