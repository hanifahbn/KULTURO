//
//  Character.swift
//  MacroApp
//
//  Created by Hanifah BN on 24/10/23.
//

import Foundation
import SwiftUI

struct Character: Identifiable, Equatable, Encodable, Decodable{
    var id = UUID()
    var name: String
    var headImage: String
    var fullImage: String
    var halfImage: String
    var origin: String
    var isChosen: Bool
}

//enum ChoosenCharacter: String, Identifiable {
//    case eyog
//    case oman
//    
//    var id: Self { return self }
//    
//    var detail: Character{
//        switch self {
//        case .eyog:
//            Character(name: "Eyog", headImage: Image("HeadOffice"), fullImage: Image(""), halfImage: Image(""), origin: "Batak", isChosen: false)
//        case .oman:
//            Character(name: "Oman", headImage: Image("HeadOffice"), fullImage: Image(""), halfImage: Image(""), origin: "Batak", isChosen: false)
//        }
//    }
//}
