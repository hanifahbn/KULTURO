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
            NaratorStories(stories: "nama1 dan nama2 adalah dua orang anak yang bersahabat namun sangat kompetitif.", nextChapter: false),
            NaratorStories(stories: "Suatu ketika mereka memutuskan untuk berlibur bersama ke rumah nenek nama1 di desa Laguboti, di Kota Medan.", nextChapter: false),
            NaratorStories(stories: "Di desa Laguboti sedang berlangsung renovasi balai desa. Nenek pun mengarahkan nama1 dan nama2 untuk membantu.",nextChapter: false),
            NaratorStories(stories: "Petualangan mereka di Desa Laguboti ini akan memberi mereka pengalaman yang berkesan.",nextChapter: false),
            NaratorStories(stories: "Dan ini lah kisahnya...",nextChapter: true)
        ]
        
        desaStories = [
            DesaStories(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStories(stories: "Hey, nama1, kita lomba, yuk. Siapa yang paling banyak membantu nanti dalam kegiatan perbaikan balai desa.", characterOne: "PersonOneDesa", characterTwo: ""),
            DesaStories(stories: "Aku yakin aku pasti lebih banyak membantu. Liat aja, ya, aku pasti lebih oke!", characterOne: "PersonTwoDesa", characterTwo: ""),
            DesaStories(stories: "Kamu pikir aku bakal tinggal diam? Aku akan berusaha sebisa mungkin!", characterOne: "PersonOneDesa", characterTwo: ""),
            DesaStories(stories: "Wah nama1 dan nama2 sudah datang, ya, mari kita ke balai desa.", characterOne: "HeadOfficeDesa", characterTwo: "HeadOffice"),
            DesaStories(stories: "Oh, iya, mari, pak.", characterOne: "Couple", characterTwo: ""),
            DesaStories(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStories(stories: "", characterOne: "PersonOne", characterTwo: "PersonTwo"),
            DesaStories(stories: "Ini dia balai desa yang akan kita renovasi. Rusaknya lumayan parah, ya?", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStories(stories: "Sekarang, saya minta tolong kalian berdua berdua beli bahan bangunan, ya, di warung ujung sana. Ini uang dan daftar yang harus dibeli.", characterOne: "HeadOfficeDesa", characterTwo: ""),
            DesaStories(stories: "Oke, pak, kami jalan sekarang.", characterOne: "Couple", characterTwo: ""),
            DesaStories(stories: "", characterOne: "", characterTwo: "")
            
        ]
        
        beliStories = [
            BeliStories(stories: "", characterOne: "Pedagang", characterTwo: "", inMissionOne: false),
            BeliStories(stories: "Beli... beli...", characterOne: "Couple", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "Oh, iya, mau beli apa?", characterOne: "PedagangDesa", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "Mau beli barang bangunan untuk renovasi balai desa, Bu.", characterOne: "Couple", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "Oh, mari sini. Mau beli apa saja kalian?", characterOne: "PedagangDesa", characterTwo: "",inMissionOne: false),
            BeliStories(stories: "Tunggu sebentar, aku tidak mau buru-buru...", characterOne: "PersonOne", characterTwo: "",inMissionOne: false),
//            BeliStories(stories: "Ucapkan barang - \n barang yang ada di\n Daftar Belanja", characterOne: "", characterTwo: "", inMissionOne: true),
        ]
        
        gudangStories = [
            GudangStorie(stories: "", characterOne: "", characterTwo: "", transisiStories: false),
            GudangStorie(stories: "Sudah semua, Bu, terimakasih. Kami pamit dulu.", characterOne: "Couple", characterTwo: "BackgroundPanglong",  transisiStories: false),
            GudangStorie(stories: "Yasudah, hati-hati kalian.", characterOne: "PedagangDesa", characterTwo: "BackgroundPanglong", transisiStories: false),
            GudangStorie(stories: "", characterOne: "HeadOffice", characterTwo: "BackgroundPanglong", transisiStories: false),
            GudangStorie(stories: "", characterOne: "HeadOffice", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "Ini pak barang-barangnya, silakan dicek.", characterOne: "Couple", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "Wah, lengkap semua, terimakasih, nak.", characterOne: "HeadOfficeDesa", characterTwo: "BrokenBalaiDesa", transisiStories: false),
            GudangStorie(stories: "Sekarang kalian bantu saya ke gudang sana untuk cari perlatan, ya.", characterOne: "HeadOfficeDesa", characterTwo: "BrokenBalaiDesa", transisiStories: false),

            GudangStorie(stories: "", characterOne: "", characterTwo: "BrokenBalaiDesa", transisiStories: true),
            GudangStorie(stories: "Oke, kita cari disini ya.", characterOne: "", characterTwo: "BackgroundGudang", transisiStories: false),
            GudangStorie(stories: "Tunggu sebentar, aku tidak mau buru-buru...", characterOne: "PersonOneDesa", characterTwo: "BackgroundGudang", transisiStories: false),
//            GudangStorie(stories: "", characterOne: "", characterTwo: "BrokenBalaiDesa", transisiStories: true)
        ]
        
        bantuDesaStories = [
            BantuDesaStories(stories: "", characterOne: "HeadOfficeDesa", characterTwo: "", transisiStories: false),
            BantuDesaStories(stories: "Ini, pak, perlengkapannya sudah ketemu.", characterOne: "Couple", characterTwo: "BackgroundGudang", transisiStories: false),
            BantuDesaStories(stories: "Wah, bagus sekali. Yuk, sekarang kita kembali ke balai desa. Tolong bantu bapak bawa barang-barang ini, ya.", characterOne: "HeadOfficeDesa", characterTwo: "BackgroundGudang", transisiStories: false),
            BantuDesaStories(stories: "", characterOne: "", characterTwo: "BackgroundGudang", transisiStories: true),
            BantuDesaStories(stories: "Wah, sudah ramai. Sudah mau mulai kayaknya.", characterOne: "Couple", characterTwo: "BackgroundDesaRamai", transisiStories: false),
            BantuDesaStories(stories: "Iya, sekarang ayo bantu berikan barang-barang ini ke warga yang lain, ya", characterOne: "HeadOfficeDesa", characterTwo: "BackgroundDesaRamai", transisiStories: false),
            BantuDesaStories(stories: "Baik, pak.", characterOne: "Couple", characterTwo: "BackgroundDesaRamai", transisiStories: false),
            BantuDesaStories(stories: "", characterOne: "", characterTwo: "BackgroundDesaRamai", transisiStories: true),
        ]
        
        pasirStories = [
            PasirStories(stories: "", characterOne: "", transisiStories: false),
            PasirStories(stories: "Sudah, pak, sudah kami bagikan semua.", characterOne: "Couple", transisiStories: false),
            PasirStories(stories: "Ada lagi yang bisa kami bantu?", characterOne: "Couple", transisiStories: false),
            PasirStories(stories: "Renovasinya akan kita mulai.", characterOne: "HeadOfficeDesa", transisiStories: false),
            PasirStories(stories: "Kalian berdua bisa coba ayak pasir di sini, ya.", characterOne: "HeadOfficeDesa", transisiStories: false),
            PasirStories(stories: "Baik, pak.", characterOne: "Couple", transisiStories: false),
            PasirStories(stories: "", characterOne: "", transisiStories: false)
        ]
        
        endStories = [
            EndStories(stories: "", characterOne: "", transisiStories: false),
            EndStories(stories: "Akhirnya selesai juga renovasinya. Terima kasih, ya, nama1 dan nama2.", characterOne: "HeadOfficeDesa", transisiStories: false),
            EndStories(stories: "Iya, pak, sama-sama. Ternyata gotong royong dengan warga asik juga, ya. Aku merasa berperan penting.", characterOne: "Couple", transisiStories: false),
            EndStories(stories: "Seru sekali bisa saling bantu kayak begini. Akhirnya liburku produktif juga, hehehe.", characterOne: "Couple", transisiStories: false),
            EndStories(stories: "Wah, wah. Saya juga senang melihat kalian mau bekerja sama dan saling membantu.", characterOne: "HeadOfficeDesa", transisiStories: false),
            EndStories(stories: "Yuk, sekarang kalian ikut acara makan-makan di rumah saya.", characterOne: "HeadOfficeDesa", transisiStories: false),
            EndStories(stories: "Ayo!", characterOne: "Couple", transisiStories: false),
            EndStories(stories: "Begitulah cerita nama1 dan nama2. Mereka yang tadinya kompetitif namun akhirnya memahami kalau saling membantu sesama adalah perbuatan yang tak kalah menyenangkan.", characterOne: "", transisiStories: true),
            EndStories(stories: "Medan Maps Success", characterOne: "", transisiStories: true)
        ]
    }
}
