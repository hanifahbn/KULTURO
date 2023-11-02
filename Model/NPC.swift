//
//  NPC.swift
//  MacroApp
//
//  Created by Hanifah BN on 02/11/23.
//

import Foundation

struct NPC: Identifiable {
    var id = UUID()
    var name: String
    var headImage: String
    var fullImage: String
    var halfImage: String
    var isNPC: Bool
}
