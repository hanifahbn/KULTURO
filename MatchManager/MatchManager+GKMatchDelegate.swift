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
        // Implementasi kode Anda untuk menangani perubahan status koneksi pemain
        switch state {
        case .connected:
            // Pemain telah terhubung
            print("Player \(player.displayName) is connected.")
        case .disconnected:
            // Pemain telah terputus
            print("Player \(player.displayName) is disconnected.")
        case .unknown:
            // Status koneksi tidak diketahui
            print("Player \(player.displayName) connection status is unknown.")
        @unknown default:
            break
        }
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
        if let receivedCharacter = try? JSONDecoder().decode(Karakter.self, from: data) {
            if let index = characters.firstIndex(where: { $0.name == receivedCharacter.name }) {
                characters[index].isChosen.toggle()
                otherCharacter = characters[index]
                
                if localCharacter != nil {
                    gameStatus = .stories
                }
            }
        } else {
            print("Failed to decode received data as Karakter.")
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
                gameStatus = .missionone
            }
        }
        if state == "ReadingSecond" {
            isFinishedReading += 1
            if(isFinishedReading == 2){
                gameStatus = .cameraGame
            }
        }
        if state == "SoundMission" {
            isFinishedPlaying += 1
            print("Yang udah kelar: \(isFinishedPlaying)")
            if(isFinishedPlaying == 2){
                gameStatus = .convoGudang
            }
        }
        if state == "CameraMission" {
            isFinishedPlaying += 1
            print("Yang udah kelar camera: \(isFinishedPlaying)")
            if(isFinishedPlaying == 2){
                gameStatus = .convoBantuDesa
            }
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
