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
    Story(text: "Hey, \(chosenCharacters[1].name), kita lomba, yuk. Siapa yang paling banyak membantu nanti dalam kegiatan perbaikan balai desa.", isTalking: chosenCharacters[0]),
    Story(text: "Aku yakin aku pasti lebih banyak membantu. Liat aja, ya, aku pasti lebih oke!", isTalking: chosenCharacters[1]),
    Story(text: "Kamu pikir aku bakal tinggal diam? Aku akan berusaha sebisa mungkin!", isTalking: chosenCharacters[0]),
    Story(text: "", isTalking: characters[4]),
    Story(text: "Wah \(chosenCharacters[0].name) dan \(chosenCharacters[1].name) sudah datang, ya, mari kita ke balai desa.", isTalking: characters[4]),
    Story(text: "Oh, iya, mari, pak.", isTalking: chosenCharacters[0]),
]

var balaiDesaStories = [
    Story(text: "Ini dia balai desa yang akan kita renovasi. Rusaknya lumayan parah, ya?", isTalking: characters[4]),
    Story(text: "Sekarang, saya minta tolong kalian berdua berdua beli bahan bangunan, ya, di warung ujung sana. Ini uang dan daftar yang harus dibeli.", isTalking: characters[4]),
    Story(text: "Oke, pak, kami jalan sekarang.", isTalking: chosenCharacters[0]),
]

var tokoStories = [
    Story(text: "Beli... beli...", isTalking: chosenCharacters[0]),
    Story(text: "Oh, iya, mau beli apa?", isTalking: characters[5]),
    Story(text: "Mau beli barang bangunan untuk renovasi balai desa, Bu.", isTalking: chosenCharacters[1]),
    Story(text: "Oh, mari sini. Mau beli apa saja kalian?", isTalking: characters[5]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var gudangStories = [
    Story(text: "Ini pak barang-barangnya, silakan dicek.", isTalking: chosenCharacters[1]),
    Story(text: "Wah, lengkap semua, terima kasih, nak.", isTalking: characters[4]),
    Story(text: "Sekarang kalian bantu saya ke gudang sana untuk cari peralatan, ya.", isTalking: characters[4]),
    Story(text: "Oke, kita cari disini.", isTalking: characters[4]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var perbaikanStoriesFirst = [
    Story(text: "Ini, pak, perlengkapannya sudah ketemu.", isTalking: chosenCharacters[1]),
    Story(text: "Wah, bagus sekali. Yuk, sekarang kita kembali ke balai desa. Tolong bantu bapak bawa barang-barang ini, ya.", isTalking: characters[4]),
    Story(text: "Wah, sudah ramai. Sudah mau mulai kayaknya.", isTalking: chosenCharacters[0]),
    Story(text: "Iya, sekarang ayo bantu berikan barang-barang ini ke warga yang lain, ya", isTalking: characters[4]),
    Story(text: "Baik, pak.", isTalking: chosenCharacters[0]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var perbaikanStoriesSecond = [
    Story(text: "Sudah, pak, sudah kami bagikan semua.", isTalking: chosenCharacters[0]),
    Story(text: "Ada lagi yang bisa kami bantu?", isTalking: chosenCharacters[1]),
    Story(text: "Renovasinya akan kita mulai.", isTalking: characters[4]),
    Story(text: "Kalian berdua bisa coba ayak pasir di sini, ya.", isTalking: characters[4]),
    Story(text: "Baik, pak.", isTalking: chosenCharacters[0]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var medanSuccessStories = [
    Story(text: "Akhirnya selesai juga renovasinya. Terima kasih, ya, \(chosenCharacters[0].name) dan \(chosenCharacters[1].name).", isTalking: characters[4]),
    Story(text: "Iya, pak, sama-sama. Ternyata gotong royong dengan warga asik juga, ya. Aku merasa berperan penting.", isTalking: chosenCharacters[0]),
    Story(text: "Seru sekali bisa saling bantu kayak begini. Akhirnya liburku produktif juga, hehehe.", isTalking: chosenCharacters[1]),
    Story(text: "Wah, wah. Saya juga senang melihat kalian mau bekerja sama dan saling membantu.", isTalking: characters[4]),
    Story(text: "Yuk, sekarang kalian ikut acara makan-makan di rumah saya.", isTalking: characters[4]),
    Story(text: "Ayo!", isTalking: chosenCharacters[0]),
]

// OLD VERSION

var desaStories = [
    Story(text: "Hey, \(chosenCharacters[1].name), kita lomba, yuk. Siapa yang paling banyak membantu nanti dalam kegiatan perbaikan balai desa.", isTalking: chosenCharacters[0]),
    Story(text: "Aku yakin aku pasti lebih banyak membantu. Liat aja, ya, aku pasti lebih oke!", isTalking: chosenCharacters[1]),
    Story(text: "Kamu pikir aku bakal tinggal diam? Aku akan berusaha sebisa mungkin!", isTalking: chosenCharacters[0]),
    Story(text: "Wah \(chosenCharacters[0].name) dan \(chosenCharacters[1].name) sudah datang, ya, mari kita ke balai desa.", isTalking: characters[4]),
    Story(text: "Oh, iya, mari, pak.", isTalking: chosenCharacters[0]),
    Story(text: "", isTalking: chosenCharacters[0]),
    Story(text: "Ini dia balai desa yang akan kita renovasi. Rusaknya lumayan parah, ya?", isTalking: characters[4]),
    Story(text: "Sekarang, saya minta tolong kalian berdua berdua beli bahan bangunan, ya, di warung ujung sana. Ini uang dan daftar yang harus dibeli.", isTalking: characters[4]),
    Story(text: "Oke, pak, kami jalan sekarang.", isTalking: chosenCharacters[0]),
]

var beliStories = [
    Story(text: "Beli... beli...", isTalking: chosenCharacters[0]),
    Story(text: "Oh, iya, mau beli apa?", isTalking: characters[5]),
    Story(text: "Mau beli barang bangunan untuk renovasi balai desa, Bu.", isTalking: chosenCharacters[1]),
    Story(text: "Oh, mari sini. Mau beli apa saja kalian?", isTalking: characters[5]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var gudangStoriesLama = [
    Story(text: "Sudah semua, Bu, terimakasih. Kami pamit dulu.", isTalking: chosenCharacters[0]),
    Story(text: "Yasudah, hati-hati kalian.", isTalking: characters[5]),
    Story(text: "Ini pak barang-barangnya, silakan dicek.", isTalking: chosenCharacters[1]),
    Story(text: "", isTalking: chosenCharacters[0]),
    Story(text: "Wah, lengkap semua, terimakasih, nak.", isTalking: characters[4]),
    Story(text: "Sekarang kalian bantu saya ke gudang sana untuk cari perlatan, ya.", isTalking: characters[4]),
    Story(text: "Oke, kita cari disini, ya.", isTalking: characters[4]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var bantuDesaStories = [
    Story(text: "Ini, pak, perlengkapannya sudah ketemu.", isTalking: chosenCharacters[1]),
    Story(text: "Wah, bagus sekali. Yuk, sekarang kita kembali ke balai desa. Tolong bantu bapak bawa barang-barang ini, ya.", isTalking: characters[4]),
    Story(text: "", isTalking: chosenCharacters[0]),
    Story(text: "Wah, sudah ramai. Sudah mau mulai kayaknya.", isTalking: chosenCharacters[0]),
    Story(text: "Iya, sekarang ayo bantu berikan barang-barang ini ke warga yang lain, ya", isTalking: characters[4]),
    Story(text: "Baik, pak.", isTalking: chosenCharacters[0]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var pasirStories = [
    Story(text: "Sudah, pak, sudah kami bagikan semua.", isTalking: chosenCharacters[0]),
    Story(text: "Ada lagi yang bisa kami bantu?", isTalking: chosenCharacters[1]),
    Story(text: "Renovasinya akan kita mulai.", isTalking: characters[4]),
    Story(text: "Kalian berdua bisa coba ayak pasir di sini, ya.", isTalking: characters[4]),
    Story(text: "Baik, pak.", isTalking: chosenCharacters[0]),
    Story(text: "Tunggu sebentar, aku tidak mau buru-buru.", isTalking: chosenCharacters[1]),
]

var endStories = [
    Story(text: "Akhirnya selesai juga renovasinya. Terima kasih, ya, \(chosenCharacters[0].name) dan \(chosenCharacters[1].name).", isTalking: characters[4]),
    Story(text: "Iya, pak, sama-sama. Ternyata gotong royong dengan warga asik juga, ya. Aku merasa berperan penting.", isTalking: chosenCharacters[0]),
    Story(text: "Seru sekali bisa saling bantu kayak begini. Akhirnya liburku produktif juga, hehehe.", isTalking: chosenCharacters[1]),
    Story(text: "Wah, wah. Saya juga senang melihat kalian mau bekerja sama dan saling membantu.", isTalking: characters[4]),
    Story(text: "Yuk, sekarang kalian ikut acara makan-makan di rumah saya.", isTalking: characters[4]),
    Story(text: "Ayo!", isTalking: chosenCharacters[0]),
]
