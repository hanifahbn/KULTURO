//
//  storyView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct StoryView: View {
    @State private var text: String = ""
    private let finalText: String = "Eyog dan Oman adalah dua anak SMP yang bersahabat yang sangat kompetitif di segala bidang, kompetisi selalu menjadi hal lumrah bagi mereka berdua. Mereka adalah anak-anak muda yang sangat individualis, kerja kelompok bagi mereka hanyalah sekadar kompetisi di dalam grup. Pada satu liburan semester, mereka memutuskan untuk berlibur ke Medan ke rumah neneknya Eyog, selain berlibur, mereka tertarik untuk ikut serta dalam mengikuti kerja bakti memperbaiki balai desa."
    //data sementara
    private var typingSpeed: Double = 0.1 // Adjust the typing speed here
    @State private var position: Int = 0

    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(lineWidth: 8)
                    .frame(width: 342, height: 170)
                    .overlay {
                        ZStack{
                            RoundedRectangle(cornerRadius: 23.0)
                                .foregroundStyle(.white)
                            Text(text)
                                .font(.system(size: 12))
                                .font(.caption)
                                .padding(10)
                        }
                    }
                    .shadow(radius: 10)
                Button("Type") {
                    typeWriter()
                }
                Spacer()
            }
        }
    }
    // nanti di pindah ke View model
    func typeWriter() {
        text = String(finalText.prefix(position))
        if position < finalText.count {
            position += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed) {
                typeWriter()
            }
        }
    }
}

#Preview {
    StoryView()
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}



