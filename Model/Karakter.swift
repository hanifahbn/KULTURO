//
//  Karakter.swift
//  MacroApp
//
//  Created by Hanifah BN on 26/10/23.
//

import Foundation
import SwiftUI

struct Karakter: Identifiable, Equatable, Encodable, Decodable{
    var id = UUID()
    var name: String
    var headImage: String
    var fullImage: String
    var halfImage: String
    var origin: String
    var color: String
    var isChosen: Bool
}
