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
        itemsToDrag =  Array(shuffledMatchToolList[0..<3])
        itemsToCollect = itemsToDrag.map { $0.bahasaName }
        
        var itemsToDragOther = Array(shuffledMatchToolList[3..<6])
        var itemsToCollectOther = itemsToDragOther.map { $0.bahasaName }
        
        itemsToCollect.append(itemsToDragOther[0].bahasaName)
        itemsToCollect.append(itemsToDragOther[1].bahasaName)
        
        itemsToCollectOther.append(itemsToDrag[0].bahasaName)
        itemsToCollectOther.append(itemsToDrag[1].bahasaName)
        
        if let encodedData = try? JSONEncoder().encode(itemsToDragOther) {
            sendData(encodedData, mode: .unreliable)
        }
        
        if let encodedDataString = try? JSONEncoder().encode(itemsToCollectOther) {
            sendData(encodedDataString, mode: .reliable)
        }
    }
    
    func sendTool(_ tool: ToolBahasa) {
        if let encodedData = try? JSONEncoder().encode(tool) {
            sendData(encodedData, mode: .unreliable)
        }
    }
}
