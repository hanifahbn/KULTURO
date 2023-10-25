//
//  storyView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct StoryNaratorView: View {
    @ObservedObject var viewModel: StoryViewModel
    @State var text: String = ""
    var typingSpeed: Double = 0.1
    @State var position: Int = 0
    @State var nextStory : Bool = false
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack{
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .stroke(lineWidth: 8)
                        .overlay {
                            ZStack{
                                RoundedRectangle(cornerRadius: 23.0)
                                    .foregroundStyle(.white)
                                    .opacity(0.8)
                                VStack{
                                    HStack{
                                        Text(text)
                                            .font(.system(size: 32, weight: .semibold,design: .rounded))
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        .shadow(radius: 10)
            }
            .padding(.top, 20)
        }
        .onAppear{
            typeWriter()
        }
        .onTapGesture {
            nextStory = true
            currentIndex += 1
            if currentIndex < viewModel.naratorStories.count {
                typeWriter()
            }
        }    }
    // nanti di pindah ke View model
    func typeWriter() {
        let Stories = viewModel.naratorStories[currentIndex].stories
        text = String(Stories.prefix(position))
        if position < Stories.count {
            position += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed) {
                typeWriter()
            }
        }
    }
}

#Preview {
    StoryNaratorView(viewModel: StoryViewModel())
}

//extension String {
//    subscript(offset: Int) -> Character {
//        self[index(startIndex, offsetBy: offset)]
//    }
//}



