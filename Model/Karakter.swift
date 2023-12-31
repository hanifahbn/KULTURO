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
    var gifImage: String?
    var origin: String?
    var colorRight: String?
    var colorLeft: String?
    var isChosen: Bool?
    var isNPC: Bool
}

var characters = [
    Karakter(name: "Asep", headImage: "HeadAsep", fullImage: "FullAsep", halfImage: "HalfAsep", gifImage: "AnimationAsep", origin: "Bandung", colorRight: "GkananBiru", colorLeft: "GkiriBiru", isChosen: false, isNPC: false),
    Karakter(name: "Togar", headImage: "HeadTogar", fullImage: "FullTogar", halfImage: "HalfTogar", gifImage: "AnimationTogar", origin: "Medan", colorRight: "GkananHijau", colorLeft: "GkiriHijau", isChosen: false, isNPC: false),
    Karakter(name: "Ajeng", headImage: "Ajeng", fullImage: "FullAjeng", halfImage: "HalfAjeng",gifImage: "AnimationAjeng", origin: "Malang", colorRight: "GkananUngu", colorLeft: "GkiriUngu", isChosen: false, isNPC: false),
    Karakter(name: "Dayu", headImage: "Dayu", fullImage: "FullDayu", halfImage: "HalfDayu",gifImage: "AnimationDayu", origin: "Denpasar", colorRight: "GkananKuning", colorLeft: "GkiriKuning", isChosen: false, isNPC: false),
    Karakter(name: "Pak kades", headImage: "", fullImage: "FullKepalaDesa", halfImage: "HalfKepalaDesa", gifImage: "AnimationKepalaDesa", isNPC: true),
    Karakter(name: "Ci mey", headImage: "", fullImage: "FullCiMei", halfImage: "HalfCiMei", isNPC: true),
]

// Ini untuk yang aktif (dipilih user). Bisa berganti,
// tapi ini dummy-nya. Nanti jadinya di stories modelnya isinya
// chosenCharacters[0], chosenCharacters[1].
var chosenCharacters = [
    Karakter(name: "Asep", headImage: "HeadAsep", fullImage: "FullAsep", halfImage: "HalfAsep", gifImage: "AnimationAsep", origin: "Bandung", colorRight: "GkananBiru", colorLeft: "GkiriBiru", isChosen: false, isNPC: false),
    Karakter(name: "Togar", headImage: "HeadTogar", fullImage: "FullTogar", halfImage: "HalfTogar", gifImage: "AnimationTogar", origin: "Medan", colorRight: "GkananHijau", colorLeft: "GkiriHijau", isChosen: false, isNPC: false),
]
