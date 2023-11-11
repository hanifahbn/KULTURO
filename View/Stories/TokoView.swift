//
//  TokoView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct TokoView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel = TransitionViewModel()
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isAnimationWalking : Bool = false
    @State var isTapGestureEnabled = false
    @State var currentIndex = 0
    //MARK: Ini tidak ada fungsimya
    //    @State var isCharacterShown = true
    //    @State var isGoingToNextView : Bool = false
    
    var body: some View {
        ZStack{
            //MARK: Ini tidak ada fungsimya
            //            Rectangle()
            //                .ignoresSafeArea()
            //                .zIndex(1)
            //                .opacity(isGoingToNextView ? 1 : 0)
            //                .animation(.easeIn(duration: 1), value: isGoingToNextView)
            Image("BackgroundPanglong")
                .resizable()
                .ignoresSafeArea()
            HStack(spacing : -30){
                ZStack{
                    GifImage("AnimationAsep")
                        .frame(width: 200, height: 220)
                        .padding(.trailing, 50)
                    GifImage("AnimationTogar")
                        .frame(width: 200, height: 220)
                        .padding(.leading, 50)
                }
            }
            .offset(x: isFirstAnimation ? 0 : -200, y: 240)
            .animation(.linear(duration: 3), value: isFirstAnimation)
            .opacity(isAnimationWalking ? 0 : 1)
            HStack(spacing : -20){
                Image(chosenCharacters[0].fullImage)
                    .resizable()
                    .frame(width: 100, height: 224)
                Image(chosenCharacters[1].fullImage)
                    .resizable()
                    .frame(width: 100, height: 224)
            }
            .opacity(isAnimationWalking ? 1 : 0)
            .offset(y: 220)
            Image(characters[5].fullImage)
                .resizable()
                .frame(width: 100, height: 200)
                .offset(x : 120, y: 150)
                .opacity(isConversation ? 0 : 1)
            VStack{
                Spacer()
                HStack{
                    Image(tokoStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                Image("TextBoxStory")
                    .resizable()
                    .frame(width: 360, height: 230)
                    .overlay {
                        VStack{
                            HStack{
                                Text(tokoStories[currentIndex].text)
                                    .font(.custom("Chalkboard-Regular", size: 30))
                                    .padding(15)
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                print("Sound")
                            }, label: {
                                Image("IconButtonSpeaker")
                                    .resizable()
                                    .frame(width: 70, height: 50)
                            })
                            .padding(.top, 130)
                            .padding(.trailing, 15)
                        }
                    }
//                    .frame(width: 350, height: 200)
            }
            .opacity(isConversation ? 1 : 0)
            TransitionOpening()
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            if isTapGestureEnabled {
                if currentIndex < tokoStories.count - 2 {
                    currentIndex += 1
                    //MARK: Ini tidak ada fungsimya
                    //                    if tokoStories[currentIndex].text == "" {
                    //                        isCharacterShown = true
                    //                        isConversation = false
                    //                        isSecondAnimation = true
                    //                        isTapGestureEnabled = false
                    //                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    //                            currentIndex += 1
                    //                            isCharacterShown = false
                    //                            isConversation = true
                    //                            isTapGestureEnabled = true
                    //                        }
                    //                    }
                }
                else {
                    isTapGestureEnabled = false
                    matchManager.isFinishedReading += 1
                    matchManager.synchronizeGameState("Reading")
                    if matchManager.isFinishedReading == 2 {
                        matchManager.gameStatus = .soundGame
                    } else {
                        currentIndex += 1
                    }
                }
            }
        }
        .onAppear{
            isConversation = true
            isFirstAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isAnimationWalking = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    isConversation = true
                    isTapGestureEnabled = true
                }
            }
        }
        
    }
}

#Preview {
    TokoView()
        .environmentObject(MatchManager())
}
