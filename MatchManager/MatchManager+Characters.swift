//
//  MatchManager+Characters.swift
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
}
