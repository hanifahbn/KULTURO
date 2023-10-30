//
//  ToolLabels.swift
//  MacroApp
//
//  Created by Auliya Michelle Adhana on 26/10/23.
//

import Foundation

struct Tool: Equatable, Encodable, Decodable {
    let imageName: String
    let objectIdentifier: String

    init(i: String, o: String) {
        imageName = i
        objectIdentifier = o
    }
}
