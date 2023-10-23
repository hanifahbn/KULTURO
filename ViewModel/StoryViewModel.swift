//
//  ViewModelStory.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 21/10/23.
//

import Foundation
import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var naratorStories : [NaratorStoriesModel] = []
    @Published var desaStories : [DesaStoriesModel] = []
    @Published var beliStories : [BeliStoriesModel] = []
    @Published var currentIndex = 1
//    @Published var
   
    init () {
        naratorStories = [
            NaratorStoriesModel(stories: "Eyog dan oman adalah dua anak smp yang bersahabat yang sangat kompetitif disegala bidang, kompetisi selalu menjadi hal lumrah untuk mereka berdua. "),
            NaratorStoriesModel(stories: "Di satu liburan semeter mereka memutuskan untuk berlibur ke rumah neneknya eyog di desa laguboti di Medan"),
            NaratorStoriesModel(stories: "Ternyata di desa tersebut sedang ada kegiatan renovasi untuk balai desa. Sang nenek pun menyuruh Eyog dan oman untuk membantu."),
            NaratorStoriesModel(stories: "Petualangan mereka di Desa Laguboti ini akan menyebabkan suatu perubahan dalam diri mereka"),
            NaratorStoriesModel(stories: "Dan ini lah kisahnya...")
        ]
        
        desaStories = [
            DesaStoriesModel(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStoriesModel(stories: "hey eyog ayo kita berlomba, siapa yang paling berkontribusi saat memperbaiki balai desa.", characterOne: "PersonOneDesa", characterTwo: ""),
            DesaStoriesModel(stories: "huh? Jangan menangis ya kalau aku yang memenangi kompetisi yang kamu buat ini", characterOne: "PersonTwoDesa", characterTwo: ""),
            DesaStoriesModel(stories: "hahaha lucu sekali teman ku yang ini, kamu pasti akan menyesal eyog", characterOne: "PersonOneDesa", characterTwo: ""),
            DesaStoriesModel(stories: "", characterOne: "HeadOffice", characterTwo: ""),
            DesaStoriesModel(stories: "wah oman dan eyog sudah datang ya, mari mari lihat balai desanya", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStoriesModel(stories: "Oh iya mari pak.", characterOne: "PersonOneDesa", characterTwo: "PersonTwoDesa"),
            DesaStoriesModel(stories: "", characterOne: "", characterTwo: ""),
            DesaStoriesModel(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStoriesModel(stories: "ini bang balai desa yang akan direnovasi, Rusaknya lumayan parah. ", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStoriesModel(stories: "sekarang kalian berdua beli bahan bangunannya dulu ya di Warung ujung sana, ini list nya yang harus kalian beli", characterOne: "HeadOfficeDesa", characterTwo: ""),
            
        ]
        
        beliStories = [
            BeliStoriesModel(stories: "", characterOne: "Pedagang", characterTwo: "", inMissionOne: false),
            BeliStoriesModel(stories: "Beli... Belii...", characterOne: "PersonOneDesa", characterTwo: "PersonTwoDesa",inMissionOne: false),
            BeliStoriesModel(stories: "oh iya bang mau beli apa?", characterOne: "PedagangDesa", characterTwo: "",inMissionOne: false),
            BeliStoriesModel(stories: "mau beli barang bangunan untuk renovasi balai desa Bu", characterOne: "PersonOneDesa", characterTwo: "PersonTwoDesa",inMissionOne: false),
            BeliStoriesModel(stories: "oh oke oke yasudah mau beli apa saja kalian?", characterOne: "PedagangDesa", characterTwo: "",inMissionOne: false),
            BeliStoriesModel(stories: "", characterOne: "", characterTwo: "", inMissionOne: true)
        ]
    }
}
