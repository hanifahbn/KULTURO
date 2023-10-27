//
//  ViewModelStory.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 21/10/23.
//

import Foundation
import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var naratorStories : [NaratorStories] = []
    @Published var desaStories : [DesaStories] = []
    @Published var beliStories : [BeliStories] = []
    @Published var gudangStories : [GudangStorie] = []
    @Published var bantuDesaStories : [BantuDesaStories] = []
    @Published var pasirStories : [PasirStories] = []
    @Published var endStories : [EndStories] = []
    @Published var currentIndex = 1
//    @Published var
   
    init () {
        naratorStories = [
            NaratorStories(stories: "Eyog dan oman adalah dua anak smp yang bersahabat yang sangat kompetitif disegala bidang, kompetisi selalu menjadi hal lumrah untuk mereka berdua. "),
            NaratorStories(stories: "Di satu liburan semeter mereka memutuskan untuk berlibur ke rumah neneknya eyog di desa laguboti di Medan"),
            NaratorStories(stories: "Ternyata di desa tersebut sedang ada kegiatan renovasi untuk balai desa. Sang nenek pun menyuruh Eyog dan oman untuk membantu."),
            NaratorStories(stories: "Petualangan mereka di Desa Laguboti ini akan menyebabkan suatu perubahan dalam diri mereka"),
            NaratorStories(stories: "Dan ini lah kisahnya...")
        ]
        
        desaStories = [
            DesaStories(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStories(stories: "hey eyog ayo kita berlomba, siapa yang paling berkontribusi saat memperbaiki balai desa.", characterOne: "PersonOneDesa", characterTwo: ""),
            DesaStories(stories: "huh? Jangan menangis ya kalau aku yang memenangi kompetisi yang kamu buat ini", characterOne: "PersonTwoDesa", characterTwo: ""),
            DesaStories(stories: "hahaha lucu sekali teman ku yang ini, kamu pasti akan menyesal eyog", characterOne: "PersonOneDesa", characterTwo: ""),
            DesaStories(stories: "", characterOne: "HeadOffice", characterTwo: ""),
            DesaStories(stories: "wah oman dan eyog sudah datang ya, mari mari lihat balai desanya", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStories(stories: "Oh iya mari pak.", characterOne: "Couple", characterTwo: ""),
            DesaStories(stories: "", characterOne: "", characterTwo: ""),
            DesaStories(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStories(stories: "ini bang balai desa yang akan direnovasi, Rusaknya lumayan parah. ", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStories(stories: "sekarang kalian berdua beli bahan bangunannya dulu ya di Warung ujung sana, ini list nya yang harus kalian beli", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStories(stories: "Oke pak, kami jalan sekarang", characterOne: "Couple", characterTwo: "")
            
        ]
        
        beliStories = [
            BeliStories(stories: "", characterOne: "Pedagang", characterTwo: "", inMissionOne: false),
            BeliStories(stories: "Beli... Belii...", characterOne: "Couple", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "oh iya bang mau beli apa?", characterOne: "PedagangDesa", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "mau beli barang bangunan untuk renovasi balai desa Bu", characterOne: "Couple", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "oh oke oke yasudah mau beli apa saja kalian?", characterOne: "PedagangDesa", characterTwo: "",inMissionOne: false),
//            BeliStories(stories: "Ucapkan barang - \n barang yang ada di\n Daftar Belanja", characterOne: "", characterTwo: "", inMissionOne: true),
        ]
        
        gudangStories = [
            GudangStorie(stories: "", characterOne: "", characterTwo: "", transisiStories: false),
            GudangStorie(stories: "Sudah semua kak, terimakasih ya, kami pamit dulu", characterOne: "Couple", characterTwo: "BackgroundPanglong",  transisiStories: false),
            GudangStorie(stories: "Yaasudah, hati hati kalian", characterOne: "PedagangDesa", characterTwo: "BackgroundPanglong", transisiStories: false),
            GudangStorie(stories: "", characterOne: "HeadOffice", characterTwo: "BackgroundPanglong", transisiStories: true),
            GudangStorie(stories: "", characterOne: "HeadOffice", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "Ini pak barang barangnya, silakan di cek dahulu", characterOne: "Couple", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "Wah lengkap semua, terimakasih nak", characterOne: "HeadOfficeDesa", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "Sekarang kalian bantu saya ke gudang sana untuk cari perlatan renovasi nya ya", characterOne: "HeadOfficeDesa", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "", characterOne: "", characterTwo: "", transisiStories: true),
            GudangStorie(stories: "Oke cari disini ya, hati hati mencarinya ya nak", characterOne: "", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "", characterOne: "", characterTwo: "BrokenBalaiDesa", transisiStories: true),
            
        ]
        
        bantuDesaStories = [
            BantuDesaStories(stories: "", characterOne: "", characterTwo: "", transisiStories: false),
            BantuDesaStories(stories: "Ini pak perlengkapannya sudah ketemu", characterOne: "Couple", characterTwo: "PersonTwoDesa", transisiStories: false),
            BantuDesaStories(stories: "Wah bagus bagus, ayuk sekarang kembali ke balai desa.tolong bantu bapak bawa barang barang ini ya", characterOne: "HeadOfficeDesa", characterTwo: "", transisiStories: false),
            BantuDesaStories(stories: "", characterOne: "", characterTwo: "", transisiStories: true),
            BantuDesaStories(stories: "Wah sudah ramai nih, sudah mau mulai ya ini pak", characterOne: "Couple", characterTwo: "", transisiStories: false),
            BantuDesaStories(stories: "Iya, sekarang kalian berdua bantu berikan barang barang ini kepada warga ya", characterOne: "HeadOfficeDesa", characterTwo: "", transisiStories: false),
            BantuDesaStories(stories: "Baik pak, kami akan lakukan dengan baik.", characterOne: "Couple", characterTwo: "", transisiStories: false),
            BantuDesaStories(stories: "", characterOne: "", characterTwo: "", transisiStories: true),
        ]
        
        pasirStories = [
            PasirStories(stories: "", characterOne: "", transisiStories: false),
            PasirStories(stories: "Sudah pak, sudah kami bagikan barang barangnya pak", characterOne: "Couple", transisiStories: false),
            PasirStories(stories: "Ada lagi yang bisa kami bantu?", characterOne: "Couple", transisiStories: false),
            PasirStories(stories: "Yasudah sekarang kalian bantu warga merenovasi ya", characterOne: "HeadOfficeDesa", transisiStories: false),
            PasirStories(stories: "Kalian berdua sekarang ayak pasir ya, hati hati kalian jangan sampai terluka", characterOne: "HeadOfficeDesa", transisiStories: false),
            PasirStories(stories: "Baik pak", characterOne: "Couple", transisiStories: false),
        ]
        
        endStories = [
            EndStories(stories: "", characterOne: "", transisiStories: false),
            EndStories(stories: "Akhirnya selesai juga renovasinya, terimakasih ya adik adik sekalian", characterOne: "HeadOfficeDesa", transisiStories: false),
            EndStories(stories: "Iya pak, sama sama. Senang sekali bisa gotong royong sama sama dengan warga sekitar", characterOne: "Couple", transisiStories: false),
            EndStories(stories: "Semuanya bekerja sama dan harmonis sekali rasanya. Bangga kami bisa berkontribusi", characterOne: "Couple", transisiStories: false),
            EndStories(stories: "Wah wah jadi dewasa sekali ya kalian berdua, senang sekali saya melihatnya", characterOne: "HeadOfficeDesa", transisiStories: false),
            EndStories(stories: "Ayuk habis ini makan makan di rumah saya sekalian bersih bersih dahulu", characterOne: "HeadOfficeDesa", transisiStories: false),
            EndStories(stories: "Ayo!", characterOne: "Couple", transisiStories: false),
            EndStories(stories: "Begitulah perjalanan gotong royong eyog dan oman, dari yang tadinya individualis menjadi dua manusia yang saling membantu satu sama lain dan menjadi paham kalau bekerja sama itu sangat menyenangkan.", characterOne: "", transisiStories: true),
            EndStories(stories: "Medan Maps Success", characterOne: "", transisiStories: true)
        ]
    }
}
