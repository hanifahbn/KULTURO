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
    Narration(text: "nama1 dan nama2 adalah dua orang anak yang bersahabat namun sangat kompetitif."),
    Narration(text: "Suatu ketika mereka memutuskan untuk berlibur bersama ke rumah nenek nama1 di desa Laguboti, di Kota Medan."),
    Narration(text: "Di desa Laguboti sedang berlangsung renovasi balai desa. Nenek pun mengarahkan nama1 dan nama2 untuk membantu."),
    Narration(text: "Petualangan mereka di Desa Laguboti ini akan memberi mereka pengalaman yang berkesan."),
    Narration(text: "Dan ini lah kisahnya..."),
]
              
var endingNarration = [
    Narration(text: "Begitulah cerita nama1 dan nama2. Mereka yang tadinya kompetitif namun akhirnya memahami kalau saling membantu sesama adalah perbuatan yang tak kalah menyenangkan."),
    Narration(text: "MEDAN MAP SUCCESS")
]
