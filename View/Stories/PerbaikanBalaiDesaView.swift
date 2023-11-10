//
//  PerbaikanBalaiDesaView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct PerbaikanBalaiDesaView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel = TransitionViewModel()
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isSecondAnimation : Bool = false
    @State var isGoingToNextView : Bool = false
    @State var isTapGestureEnabled = false
    @State var isCharacterShown = true
    @State var currentIndex = 0
    @State var stories = perbaikanStoriesFirst
    @State var nextGameStatus: GameStatus = .dragAndDrop

    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(isGoingToNextView ? 1 : 0)
                .animation(.easeIn(duration: 1), value: isGoingToNextView)
            Image("BackgroundDesaRamai")
                .resizable()
                .ignoresSafeArea()
            HStack{
                HStack(spacing : -30){
                    Image(chosenCharacters[0].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                    Image(chosenCharacters[1].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                }.padding()
                    .offset(x: isFirstAnimation ? 20 : -200, y: 160)
                    .animation(.linear(duration: 1.5), value: isFirstAnimation)
                Image(characters[4].fullImage)
                    .resizable()
                    .frame(width: 110, height: 226)
                    .padding(.top, 300)
                    
            }
            .opacity(isCharacterShown ? 1 : 0)
            VStack{
                Spacer()
                HStack{
                    Image(stories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(stories[currentIndex].text)
                                    .font(.custom("Chalkboard-Regular", size: 30))
                                    .padding(15)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isConversation ? 1 : 0)
            TransitionOpening()
            TransitionClosing(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            if isTapGestureEnabled {
                if currentIndex < stories.count - 2 {
                    currentIndex += 1
                    if stories[currentIndex].text == "" {
                        isCharacterShown = true
                        isConversation = false
                        isSecondAnimation = true
                        isTapGestureEnabled = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            currentIndex += 1
                            isCharacterShown = false
                            isConversation = true
                            isTapGestureEnabled = true
                        }
                    }
                }
                else {
                    isTapGestureEnabled = false
                    matchManager.isFinishedReading += 1
                    if nextGameStatus == .dragAndDrop {
                        matchManager.synchronizeGameState("ReadingThird")
                        if matchManager.isFinishedReading == 2 {
                            viewModel.startTransition()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                matchManager.gameStatus = nextGameStatus
                            }
                        }
                    }
                    else {
                        matchManager.synchronizeGameState("ReadingFourth")
                        if matchManager.isFinishedReading == 2 {
                            viewModel.startTransition()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                matchManager.gameStatus = nextGameStatus
                            }
                        } else {
                            currentIndex += 1
                        }
                    }
                }
            }
        }
        .onAppear{
            isFirstAnimation = true
            matchManager.stopTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                isConversation = true
                isTapGestureEnabled = true
                isConversation = true
                isCharacterShown = false
            }
        }

    }
}

#Preview {
    PerbaikanBalaiDesaView()
        .environmentObject(MatchManager())
}
