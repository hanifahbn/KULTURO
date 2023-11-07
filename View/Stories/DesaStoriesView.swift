//
//  DesaStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 21/10/23.
//

import SwiftUI

struct DesaStoriesView: View {
    @EnvironmentObject var matchManager: MatchManager
//    @StateObject var viewModel: StoryViewModel = StoryViewModel()
    @State private var currentIndex = 0
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    @State var isTapGestureEnabled = true
    @State var OpacityCharacter = false

    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(isNextStory ? 1 : 0)
                .animation(.easeIn(duration: 1), value: isNextStory)
            if currentIndex > 5{
                Image("BrokenBalaiDesa")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image("BackgroundImageGapura")
                    .resizable()
                    .ignoresSafeArea()
            }
            HStack{
                HStack(spacing : -30){
                    Image(chosenCharacters[0].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                        .padding(.top, 40)
                    Image(chosenCharacters[1].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                    Spacer()
                    Image(characters[4].fullImage)
                        .resizable()
                        .opacity(isAnimation1 ? 1 : 0)
                        .frame(width: 110, height: 226)
                        .offset(x: isAnimation1 ?  0 : 100)
                        .animation(.linear(duration: 1.5), value: isAnimation1)

                }
                .padding(.top, 200)
                .offset(x: isAnimation ? 10 : -200)
                .animation(.linear(duration: 2.5), value: isAnimation)
                .opacity(OpacityCharacter ? 0 : 1)
            }
            //            .offset(x: isAnimation1 ? 400 : 0)

            VStack{
                Spacer()
                HStack{
                    Image(desaStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                if(chosenCharacters.isEmpty){
                                    Text(desaStories[currentIndex].text)
                                        .font(.system(size: 25, weight: .medium, design: .rounded))
                                        .padding(15)
                                }
                                else{
                                    Text(desaStories[currentIndex].text)
                                        .font(.system(size: 25, weight: .medium, design: .rounded))
                                        .padding(15)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isStory ? 1 : 0)
            //            .animation(.linear(duration: 0.2), value: isStory)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            if isTapGestureEnabled {
                currentIndex += 1
                if currentIndex == 3 {
                    isStory = false
                    isAnimation1 = true
                    isTapGestureEnabled = false
                    OpacityCharacter = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isStory = true
                        isTapGestureEnabled = true
                        OpacityCharacter = true
                    }
                } else if currentIndex == 5 {
                    isStory = false
                    isAnimation = false
                    isAnimation1 = false
                    isNextStory = true
                    isTapGestureEnabled = false
                    OpacityCharacter = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isNextStory = false
                        currentIndex += 1
                        isStory = false
                        isAnimation1 = true
                        isAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                            viewModel.currentIndex = 4
                            isStory = true
                            isTapGestureEnabled = true
                            OpacityCharacter = true
                        }

                    }
                } 
                else if currentIndex == 8 {

                    isStory = false
                    isAnimation = false
                    isNextStory = true
                    isTapGestureEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        matchManager.gameStatus = .convoBeli
                    }
                }
            }
        }
        .onAppear{
            isAnimation = true
            isTapGestureEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                isStory = true
                isTapGestureEnabled = true
                OpacityCharacter = true

            }
        }

    }
}

#Preview {
    DesaStoriesView()
        .environmentObject(MatchManager())
}
