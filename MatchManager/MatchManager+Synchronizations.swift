//
//  MatchManager+Synchronizations.swift
//  MacroApp
//
//  Created by Hanifah BN on 25/10/23.
//

import Foundation
import GameKit

extension MatchManager{
    func synchronizeCharacterSelection(_ selectedCharacter: Karakter) {
        if let encodedData = try? JSONEncoder().encode(selectedCharacter) {
            sendData(encodedData, mode: .unreliable)
        }
    }
    
    func synchronizeGameState(_ updatedState: String) {
        if let encodedData = updatedState.data(using: .utf8) {
            sendData(encodedData, mode: .unreliable)
        }
    }
    
    func synchronizeGameCharacters(_ characters: [Karakter]) {
        if let encodedData = try? JSONEncoder().encode(characters) {
            sendData(encodedData, mode: .reliable)
        }
    }
}
