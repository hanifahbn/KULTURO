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
            sendData(encodedData, mode: .unreliable)
        }
    }
    
    func distributeItems() {
        let shuffledMatchToolList = matchToolList.shuffled()
        itemsToDrag = []
        itemsToCollect = []
        
        itemsToDrag =  Array(shuffledMatchToolList[0..<4])
        itemsToCollect = Array(shuffledMatchToolList[0..<3]).map { $0.bahasaName }
        
        let itemsToDragOther = Array(shuffledMatchToolList[4..<8])
        var itemsToCollectOther = Array(shuffledMatchToolList[4..<7]).map { $0.bahasaName }
        
        itemsToCollect.insert(shuffledMatchToolList[7].bahasaName, at: 2)
        
        itemsToCollectOther.insert(shuffledMatchToolList[3].bahasaName, at: 2)
        
        if let encodedData = try? JSONEncoder().encode(itemsToDragOther) {
            sendData(encodedData, mode: .unreliable)
        }
        
        if let encodedDataString = try? JSONEncoder().encode(itemsToCollectOther) {
            sendData(encodedDataString, mode: .unreliable)
        }
    }
    
    func sendTool(_ tool: ToolBahasa) {
        if let encodedData = try? JSONEncoder().encode(tool) {
            sendData(encodedData, mode: .unreliable)
        }
    }
    
    func informVoiceChatActivation(_ updatedState: String) {
        if let encodedData = updatedState.data(using: .utf8) {
            sendData(encodedData, mode: .unreliable)
        }
    }
}
