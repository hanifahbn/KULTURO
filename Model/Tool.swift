//
//  Tools.swift
//  MacroApp
//
//  Created by Hanifah BN on 27/10/23.
//  Created by Auliya Michelle Adhana on 26/10/23.
//

import Foundation

//struct Tool: Identifiable, Equatable, Encodable, Decodable{
//    var id = UUID()
//    var localName: String
//    var bahasaName: String
//    var exampleAudioURL: String
struct Tool: Equatable {
    let imageName: String
    let objectIdentifier: String

    init(i: String, o: String) {
        imageName = i
        objectIdentifier = o
    }
}
