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
    Narration(text: "\(chosenCharacters[0].name) dan \(chosenCharacters[1].name) adalah dua anak smp yang bersahabat yang sangat kompetitif disegala bidang, kompetisi selalu menjadi hal lumrah untuk mereka berdua."),
    Narration(text: "Di satu liburan semeter mereka berlibur ke rumah Ibu guru mereka di desa laguboti di Medan untuk membantu kegiatan renovasi balai desa di sana."),
    Narration(text: "Petualangan mereka di Desa Laguboti ini akan memberi mereka pengalaman yang berkesan."),
    Narration(text: "Dan ini lah kisahnya..."),
]
              
var endingNarration = [
    Narration(text: "Begitulah cerita \(chosenCharacters[0].name) dan \(chosenCharacters[1].name). Mereka yang tadinya kompetitif namun akhirnya memahami kalau saling membantu sesama adalah perbuatan yang tak kalah menyenangkan."),
    Narration(text: "MEDAN MAP SUCCESS")
]
