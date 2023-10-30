//
//  Tools.swift
//  MacroApp
//
//  Created by Hanifah BN on 27/10/23.
//

import Foundation

struct ToolBahasa: Identifiable, Equatable, Encodable, Decodable {
    var id = UUID()
    var localName: String
    var bahasaName: String
    var labelName: String
    var exampleAudioURL: String
}
