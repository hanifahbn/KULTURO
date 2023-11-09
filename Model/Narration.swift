//
//  Narration.swift
//  MacroApp
//
//  Created by Hanifah BN on 02/11/23.
//

import Foundation

struct Narration: Identifiable {
    var id = UUID()
    var text: String
    var audioURL: String?
}

var beginningNarration = [
    Narration(text: "\(chosenCharacters[0].name) dan \(chosenCharacters[1].name) adalah dua anak SMP yang berteman namun selalu ingin berkompetisi satu sama lain, dalam hal apapun."),
    Narration(text: "Di suatu liburan semester, mereka berlibur ke rumah ibu guru di desa Laguboti di Medan untuk membantu kegiatan renovasi balai desa."),
    Narration(text: "Petualangan mereka di Desa Laguboti akan memberi mereka pengalaman yang berkesan. Beginilah kisahnya..."),
]
              
var endingNarration = [
    Narration(text: "Begitulah cerita \(chosenCharacters[0].name) dan \(chosenCharacters[1].name). Mereka yang tadinya kompetitif namun akhirnya memahami kalau saling membantu sesama adalah perbuatan yang tak kalah menyenangkan."),
    Narration(text: "MEDAN MAP SUCCESS. SEE YOU IN ANOTHER VILLAGE.")
]
