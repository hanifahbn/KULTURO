//
//  storyView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct StoryNaratorView: View {
    @ObservedObject var viewModel: StoryViewModel
    @EnvironmentObject var matchManager: MatchManager
    
    @State var text: String = ""
    var typingSpeed: Double = 0.1
    @State var position: Int = 0
    @State var nextStory : Bool = false
    @State private var currentIndex = 0
    @State private var isFirstTap = true
    
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack{
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(lineWidth: 1)
                    .overlay {
                        ZStack{
                            RoundedRectangle(cornerRadius: 23.0)
                                .foregroundStyle(.white)
                                .opacity(0.8)
                            VStack{
                                HStack{
                                    Text(nextStory ? viewModel.naratorStories[currentIndex].stories: text)
                                        .font(.system(size: 28, weight: .semibold,design: .rounded))
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .frame(width: 350, height: 300)
                    .shadow(radius: 10)
            }
            .padding(.top, 20)
        }
        .onAppear{
            typeWriter()
        }
        .onTapGesture {
            if isFirstTap {
                isFirstTap = false 
                nextStory = true
            } else {
                goToNextStory()
                if currentIndex < viewModel.naratorStories.count {
                    isFirstTap = true
                }
            }
        }
    }
    
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
    
    func goToNextStory() {
        currentIndex += 1
        if currentIndex < viewModel.naratorStories.count {
            position = 0
            text = ""
            typeWriter()
            nextStory = false
        }
        else if currentIndex == viewModel.naratorStories.count {
            position = 0
            nextStory = false
            matchManager.gameStatus = .convoBalaiDesa
        }
    }
}

#Preview {
    StoryNaratorView(viewModel: StoryViewModel())
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}



