//
//  GudangView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct GudangView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel = TransitionViewModel()
    @State var player = PlayerViewModel()
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isAnimationWalking : Bool = false
    @State var isTapGestureEnabled = false
    @State var currentIndex = 0
    @State var soundOnOff : Bool = false
    //MARK: Ini tidak ada fungsimya
    //    @State var isCharacterShown = true
    //    @State var isGoingToNextView : Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                //MARK: Ini tidak ada fungsimya
                //            Rectangle()
                //                .ignoresSafeArea()
                //                .zIndex(1)
                //                .opacity(isGoingToNextView ? 1 : 0)
                //                .animation(.easeIn(duration: 1), value: isGoingToNextView)
                Image("BackgroundGudang")
                    .resizable()
                    .ignoresSafeArea()
                //            if currentIndex >= 2{
                //                VStack{
                //                    Rectangle()
                //                        .frame(height: 50)
                //                        .foregroundStyle(Color.kuning)
                //                        .overlay {
                //                            Text("Mission 2  >>")
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
                        Image(gudangStories[currentIndex].isTalking.halfImage)
                    }
                    .padding(.bottom, -300)
                    Image("TextBoxStory")
                        .resizable()
                        .frame(width: geometry.size.width / 1, height: geometry.size.height / 3)
                        .overlay {
                            VStack(spacing : -15){
                                HStack{
                                    Text("\(gudangStories[currentIndex].isTalking.name)")
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(Color.darkRed)
                                    
                                        .padding(geometry.size.width * 0.037)
                                    Spacer()
                                }
                                HStack{
                                    Text(gudangStories[currentIndex].text)
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(.black)
                                        .padding(geometry.size.width * 0.025)
                                        .onAppear{
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                                player.playMultipleSound(fileName: gudangStories[currentIndex].audioURL!)
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
                                    
                                    player.playMultipleSound(fileName: gudangStories[currentIndex].audioURL!)

                                }, label: {
                                    Image("BackgroundButtonSound")
                                        .overlay{
                                            Image("SoundOn")
                                        }
                                })
                                .padding(.top, 130)
                                .padding(geometry.size.width * 0.06)
                                .opacity(currentIndex == gudangStories.count - 1 ? 0 : 1)
                            }
                        }
                }
                .opacity(isConversation ? 1 : 0)
                //            TransitionOpening()
            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                if isTapGestureEnabled {
                    if currentIndex < gudangStories.count - 2 {
                        currentIndex += 1
                        player.playMultipleSound(fileName: gudangStories[currentIndex].audioURL!)
                        //MARK: Ini tidak ada fungsimya
                        //                    if gudangStories[currentIndex].text == "" {
                        //                        isCharacterShown = true
                        //                        isConversation = false
                        //                        isAnimationWalking = true
                        //                        isTapGestureEnabled = false
                        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        //                            currentIndex += 1
                        //                            isCharacterShown = false
                        //                            isConversation = true
                        //                            isTapGestureEnabled = true
                        //                        }
                        //                    }
                        //MARK: =========
                    }
                    else {
                        isTapGestureEnabled = false
                        matchManager.isFinishedReading += 1
                        matchManager.synchronizeGameState("ReadingSecond")
                        if matchManager.isFinishedReading == 2 {
                            matchManager.gameStatus = .cameraGame
                        } else {
                            player.playBacksoundOnly()
                            currentIndex += 1
                        }
                    }
                }
            }
            .onAppear{
                matchManager.isFinishedReading = 0
                player.playAudioLoop(fileName: "backsound-village")
                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                    player.playAudioLoop(fileName:"backsound-village", volume: 0.06)
                }
                isFirstAnimation = true
                matchManager.stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isAnimationWalking = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        isConversation = true
                        isTapGestureEnabled = true
                    }
                }
            }
        }
    }
}

#Preview {
    GudangView()
        .environmentObject(MatchManager())
}
