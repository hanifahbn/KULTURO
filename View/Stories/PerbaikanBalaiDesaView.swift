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
    @State var player = PlayerViewModel()
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isAnimationWalking : Bool = false
    //    @State var isGoingToNextView : Bool = false
    @State var isTapGestureEnabled = false
    //    @State var isCharacterShown = true
    @State var currentIndex = 0
    @State var stories = perbaikanStoriesSecond
    @State var nextGameStatus: GameStatus = .dragAndDrop
    @State var soundOnOff : Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                //MARK: Ini tidak ada fungsimya
                // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
                //            Rectangle()
                //                .ignoresSafeArea()
                //                .zIndex(1)
                //                .opacity(isGoingToNextView ? 1 : 0)
                //                .animation(.easeIn(duration: 1), value: isGoingToNextView)
                Image("BackgroundDesaRamai")
                    .resizable()
                    .ignoresSafeArea()
                //            if currentIndex == 2 || currentIndex == 6{
                //                VStack{
                //                    Rectangle()
                //                        .frame(height: 50)
                //                        .foregroundStyle(Color.kuning)
                //                        .overlay {
                //                            Text("Mission 3  >>")
                //                                .font(.system(size: 28, weight: .semibold))
                //                                .foregroundStyle(Color.blueTurtle)
                //                                .shadow(color: .white ,radius: 0, y: 1)
                //                        }
                //                    Spacer()
                //                }
                //            }
                HStack(spacing : -30){
                    ZStack{
                        GifImage(chosenCharacters[0].gifImage!)
                            .frame(width: 200, height: 220)
                            .padding(.trailing, 50)
                        GifImage(chosenCharacters[1].gifImage!)
                            .frame(width: 200, height: 220)
                            .padding(.leading, 50)
                    }
                }
                .offset(x: isFirstAnimation ? 0 : -200, y: 200)
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
                .offset(y: 200)
                Image(characters[4].fullImage)
                    .resizable()
                    .frame(width: 100, height: 200)
                    .offset(x : 120, y: 150)
                    .opacity(isConversation ? 0 : 1)
                VStack{
                    Spacer()
                    HStack{
                        Image(stories[currentIndex].isTalking.halfImage)
                    }
                    .padding(.bottom, -300)
                    Image("TextBoxStory")
                        .resizable()
                        .frame(width: geometry.size.width / 1, height: geometry.size.height / 3)
                        .overlay {
                            VStack(spacing : -15){
                                HStack{
                                    Text("\(stories[currentIndex].isTalking.name)")
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(Color.darkRed)
                                    
                                        .padding(geometry.size.width * 0.037)
                                    Spacer()
                                }
                                HStack{
                                    Text(stories[currentIndex].text)
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(.black)
                                        .padding(geometry.size.width * 0.025)
                                        .onAppear{
                                            if currentIndex == 0 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                                    player.playMultipleSound(fileName: stories[currentIndex].audioURL!)

                                                }
                                            }
                                        }
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                            HStack{
                                Spacer()
                                Button(action: {
                                    player.playMultipleSound(fileName: stories[currentIndex].audioURL!)
                                    
                                }, label: {
                                    Image("BackgroundButtonSound")
                                        .overlay{
                                            Image("SoundOn")
                                        }
                                })
                                .padding(.top, 130)
                                .padding(geometry.size.width * 0.06)
                                .opacity(currentIndex == stories.count - 1 ? 0 : 1)
                            }
                        }
                }
                .opacity(isConversation ? 1 : 0)
                //            TransitionOpening()
                //            TransitionClosing(viewModel: viewModel)
            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                if isTapGestureEnabled {
                    if currentIndex < stories.count - 2 {
                        currentIndex += 1
                        player.playMultipleSound(fileName: stories[currentIndex].audioURL!)
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
                            } else {
                                currentIndex += 1
                                matchManager.distributeItems()
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
                                player.playBacksoundOnly()
                            }
                        }
                    }
                }
            }
            .onAppear{
                player.playAudioLoop(fileName: "backsound-crowd")
                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                    player.playAudioLoop(fileName: "backsound-crowd", volume: 0.5)
                }
                isFirstAnimation = true
                matchManager.stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isAnimationWalking = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isConversation = true
                        isTapGestureEnabled = true
                        //                    isCharacterShown = false
                    }

                }
            }
        }
    }
}

#Preview {
    PerbaikanBalaiDesaView()
        .environmentObject(MatchManager())
}
