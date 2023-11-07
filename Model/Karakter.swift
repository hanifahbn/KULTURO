//
//  Karakter.swift
//  MacroApp
//
//  Created by Hanifah BN on 26/10/23.
//

import Foundation

// Yang ada ? bisa nil karena untuk NPC.
struct Karakter: Identifiable, Equatable, Encodable, Decodable{
    var id = UUID()
    var name: String
    var headImage: String
    var fullImage: String
    var halfImage: String
    var origin: String?
    var colorRight: String?
    var colorLeft: String?
    var isChosen: Bool?
    var isNPC: Bool
}

var characters = [
    Karakter(name: "Asep", headImage: "HeadAsep", fullImage: "FullAsep", halfImage: "HalfAsep", origin: "Bandung", colorRight: "GkananBiru", colorLeft: "GkiriBiru", isChosen: false, isNPC: false),
    Karakter(name: "Togar", headImage: "HeadTogar", fullImage: "FullTogar", halfImage: "HalfTogar", origin: "Medan", colorRight: "GkananHijau", colorLeft: "GkiriHijau", isChosen: false, isNPC: false),
    Karakter(name: "Ajeng", headImage: "Ajeng", fullImage: "", halfImage: "", origin: "Bali", colorRight: "GkananUngu", colorLeft: "GkiriUngu", isChosen: false, isNPC: false),
    Karakter(name: "Dayu", headImage: "Dayu", fullImage: "", halfImage: "", origin: "Bali", colorRight: "GkananKuning", colorLeft: "GkiriKuning", isChosen: false, isNPC: false),
    Karakter(name: "Pak Kades", headImage: "", fullImage: "FullKepalaDesa", halfImage: "HalfKepalaDesa", isNPC: true),
    Karakter(name: "Ci Mei", headImage: "", fullImage: "FullCiMei", halfImage: "HalfCiMei", isNPC: true),
]

// Ini untuk yang aktif (dipilih user). Bisa berganti,
// tapi ini dummy-nya. Nanti jadinya di stories modelnya isinya
// chosenCharacters[0], chosenCharacters[1].
var chosenCharacters = [
    Karakter(name: "Asep", headImage: "Gale", fullImage: "FullAsep", halfImage: "HalfAsep", origin: "Bandung", colorRight: "GkananBiru", colorLeft: "GkiriBiru", isChosen: false, isNPC: false),
    Karakter(name: "Togar", headImage: "Eyog", fullImage: "FullTogar", halfImage: "HalfTogar", origin: "Medan", colorRight: "GkananHijau", colorLeft: "GkiriHijau", isChosen: false, isNPC: false),
]
