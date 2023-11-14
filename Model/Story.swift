//
//  Story.swift
//  MacroApp
//
//  Created by Hanifah BN on 02/11/23.
//

import Foundation

struct Story: Identifiable {
    var id = UUID()
    var text: String
    var isTalking: Karakter
    var audioURL: String?
}

var gapuraStories = [
    Story(text: "Hey, \(chosenCharacters[1].name), kita lomba, yuk. Siapa yang paling banyak membantu dalam kegiatan perbaikan balai desa.", isTalking: chosenCharacters[0]),
    Story(text: "Ya jelas aku, lah!", isTalking: chosenCharacters[1]),
    Story(text: "", isTalking: characters[4]),
    Story(text: "Wah \(chosenCharacters[0].name) dan \(chosenCharacters[1].name) sudah datang, ya, mari kita ke balai desa.", isTalking: characters[4]),
    Story(text: "Oh, iya, mari, pak.", isTalking: chosenCharacters[0]),
]

var balaiDesaStories = [
    Story(text: "Selamat datang di Desa Laguboti. Ini adalah balai desa yang akan kita renovasi.", isTalking: characters[4], audioURL: String(characters[4].name) + " 1"),
    Story(text: "Oh, iya, Pak. Kami akan membantu semampu kami.", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 1"),
    Story(text: "Baik, sekarang kalian beli bahan bangunannya, ya, di warung depan sana. Ini daftar barang yang harus dibeli.", isTalking: characters[4], audioURL: String(characters[4].name) + " 2"),
    Story(text: "Oke, pak, kami jalan sekarang.", isTalking: chosenCharacters[1], audioURL: String(chosenCharacters[1].name) + " 2"),
]

var tokoStories = [
    Story(text: "Beli... beli...", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 3"),
    Story(text: "Oh, iya, mau beli apa?", isTalking: characters[5], audioURL: String(characters[5].name) + " 1"),
    Story(text: "Mau beli barang bangunan untuk renovasi balai desa, Kak.", isTalking: chosenCharacters[1], audioURL: String(chosenCharacters[1].name) + " 4"),
    Story(text: "Oh, baik. Mau beli apa saja kalian?", isTalking: characters[5], audioURL: String(characters[5].name) + " 2"),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var gudangStories = [
    Story(text: "Ini, Pak, barang-barangnya. Silakan dicek.", isTalking: chosenCharacters[1], audioURL: String(chosenCharacters[1].name) + " 6"),
    Story(text: "Wah, lengkap semua. Terima kasih, nak.", isTalking: characters[4], audioURL: String(characters[4].name) + " 3"),
    Story(text: "Sekarang kalian bantu saya untuk cari peralatan di gudang sana, ya.", isTalking: characters[4], audioURL: String(characters[4].name) + " 4"),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var perbaikanStoriesFirst = [
    Story(text: "Ini, pak, perlengkapannya sudah ketemu.", isTalking: chosenCharacters[1], audioURL: String(chosenCharacters[1].name) + " 7"),
    Story(text: "Baik, sekarang kalian berdua bantu berikan barang-barang ini kepada warga, ya.", isTalking: characters[4], audioURL: String(characters[4].name) + " 7"),
    Story(text: "Baik, Pak. Kami akan lakukan dengan baik.", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 9"),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var perbaikanStoriesSecond = [
    Story(text: "Sudah, Pak. Sudah kami bagikan barang-barangnya.", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 10"),
    Story(text: "Ada lagi yang bisa kami bantu?", isTalking: chosenCharacters[1], audioURL: String(chosenCharacters[1].name) + " 11"),
    Story(text: "Yasudah, sekarang kalian bantu warga merenovasi, ya.", isTalking: characters[4], audioURL: String(characters[4].name) + " 8"),
    Story(text: "Kalian berdua bisa ayak pasir, ya. Hati-hati, jangan sampai terluka.", isTalking: characters[4], audioURL: String(characters[4].name) + " 9"),
    Story(text: "Baik, pak.", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 12"),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var medanSuccessStories = [
    Story(text: "Akhirnya selesai juga renovasinya. Terima kasih, ya, adik-adik sekalian.", isTalking: characters[4], audioURL: String(characters[4].name) + " 10"),
    Story(text: "Iya, pak, sama-sama. Senang sekali bisa bergotong-royong dengan warga sekitar.", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 13"),
    Story(text: "Semuanya bekerjasama dan harmonis sekali rasanya. Kami bangga bisa berkontribusi.", isTalking: chosenCharacters[1], audioURL: String(chosenCharacters[1].name) + " 14"),
    Story(text: "Wah, wah, jadi dewasa sekali, ya, kalian berdua. Senang sekali saya melihatnya.", isTalking: characters[4], audioURL: String(characters[4].name) + " 11"),
    Story(text: "Yuk, sekarang kalian ikut acara makan-makan di rumah saya sekalian bersih-bersih.", isTalking: characters[4], audioURL: String(characters[4].name) + " 12"),
    Story(text: "Ayo!", isTalking: chosenCharacters[0], audioURL: String(chosenCharacters[0].name) + " 15"),
]
