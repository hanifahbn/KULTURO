//
//  storyView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct StoryNarratorView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel = TransitionViewModel()
    @State var Stories: String = ""
    @State var text: String = ""
    var typingSpeed: Double = 0.05
    @State var position: Int = 0
    @State var nextStory : Bool = false
    @State private var currentIndex = 0
    @State private var isFirstTap = true
    @State var isTapGestureEnabled = true
    @State var narration = beginningNarration
    @State var nextGameStatus: GameStatus = .storyBalaiDesa
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Image("BalaiDesaRenovated")
                    .resizable()
                    .blur(radius: 4)
                    .ignoresSafeArea()
                VStack{
                    Image("TextBoxNarasi")
                        .resizable()
//                        .frame(width: 400, height: 400)
                        .frame(width: geometry.size.width * 1, height: geometry.size.height / 2)
                        .overlay {
                            VStack{
                                HStack{
                                    if(!chosenCharacters.isEmpty){
                                        Text(nextStory ? narration[currentIndex].text : text)
                                            .font(.custom("Chalkboard-Regular", size: 30))
                                            .foregroundStyle(.black)
                                    }
                                    else{
                                        Text(nextStory ? narration[currentIndex].text : text)
                                            .font(.custom("Chalkboard-Regular", size: 30))
                                            .foregroundStyle(.black)
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding(geometry.size.width * 0.066)
                            .padding(.top, geometry.size.width * 0.076)

                            
                        }
                        .shadow(radius: 10)
                }
                TransitionClosing(viewModel: viewModel)
                HStack{
                    Spacer()
                    Button(action: {
                        print("Sound")
                    }, label: {
                        Image("IconButtonSpeaker")
                            .resizable()
                            .frame(width: 70, height: 50)
                    })
//                    .padding(.top, 200)
//                    .padding(.trailing, 10)
                    .opacity(0)
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear{
                typeWriter()
                //            matchManager.gameStatus = .cameraGame
            }
        }
        .onTapGesture {
            if isTapGestureEnabled {
                if isFirstTap {
                    isFirstTap = false
                    nextStory = true
                } else {
                    goToNextStory()
                    if currentIndex < narration.count {
                        isFirstTap = true
                    }
                }
            }
        }
    }
    
    // nanti di pindah ke View model
    func typeWriter() {
        if(!chosenCharacters.isEmpty){
            Stories = narration[currentIndex].text
        }
        else{
            Stories = narration[currentIndex].text
        }
        text = String(Stories.prefix(position))
        if position < Stories.count {
            position += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed) {
                typeWriter()
            }
        }
    }
    
    func goToNextStory() {
        if currentIndex < narration.count - 1 {
            currentIndex += 1
            position = 0
            text = ""
            typeWriter()
            nextStory = false
        }
        else {
            isTapGestureEnabled = false
            position = 0
            //            nextStory = false
            viewModel.startTransition()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                matchManager.gameStatus = nextGameStatus
            }
        }
    }
}

#Preview {
    StoryNarratorView()
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}



