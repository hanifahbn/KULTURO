//
//  Tools.swift
//  MacroApp
//
//  Created by Hanifah BN on 27/10/23.
//

import Foundation

struct ToolBahasa: Identifiable, Equatable, Encodable, Decodable, Hashable {
    var id = UUID()
    var localName: String?
    var bahasaName: String
    var labelName: String?
    var image: String?
    var width: CGFloat?
    var height: CGFloat?
    var exampleAudioURL: String?
}

var toolList: [ToolBahasa] = [
    ToolBahasa(localName: "Apusapus Ni Pat", bahasaName: "Keset", labelName:"ApusapusNiPat", exampleAudioURL: "ApusapusNiPat"),
    ToolBahasa(localName: "Sipadot", bahasaName: "Sapu", labelName:"Sipadot", image: "Sapu", width: 200, height: 200, exampleAudioURL: "Sipadot"),
    ToolBahasa(localName: "Tel", bahasaName: "Ember", labelName:"Tel", image: "Ember", width: 100, height: 100, exampleAudioURL: "Tel"),
    ToolBahasa(localName: "Inganan Sampah", bahasaName: "Tempat Sampah", labelName:"IngananSampah", exampleAudioURL: "IngananSampah"),
    ToolBahasa(localName: "Jom Dinding", bahasaName: "Jam Dinding", labelName:"JomDinding", exampleAudioURL: "JomDinding"),
    ToolBahasa(bahasaName: "Keranjang", labelName:"Keranjang", image: "Keranjang", width: 110, height: 110),
    ToolBahasa(bahasaName: "Palu", image: "Palu", width: 90, height: 90),
    ToolBahasa(bahasaName: "Kapak", image: "Kapak", width: 110, height: 110),
    ToolBahasa(bahasaName: "Tisu", image: "Tisu", width: 60, height: 60),
    ToolBahasa(bahasaName: "Paku", image: "Paku", width: 40, height: 40),
    ToolBahasa(bahasaName: "Penggaris", image: "Penggaris", width: 80, height: 80)
]
