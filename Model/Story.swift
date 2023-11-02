//
//  Story.swift
//  MacroApp
//
//  Created by Hanifah BN on 02/11/23.
//

import Foundation

struct Story: Identifiable {
    var id = UUID()
    var text: String
    var isTalking: Karakter?
    var audioURL: String?
}
