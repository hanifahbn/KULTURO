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
    //MARK: Ini tidak ada fungsimya
    //    @State var isCharacterShown = true
    //    @State var isGoingToNextView : Bool = false
    @EnvironmentObject var router : RouterViewStack
    
    var body: some View {
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
                    .frame(width: 360, height: 250)
                    .overlay {
                        VStack{
                            HStack{
                                Text(gudangStories[currentIndex].text)
                                    .font(.custom("Chalkboard-Regular", size: 30))
                                    .foregroundStyle(.black)
                                    .padding(15)
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                player.playAudioStory(fileName: gudangStories[currentIndex].audioURL!)
                            }, label: {
                                Image("IconButtonSpeaker")
                                    .resizable()
                                    .frame(width: 70, height: 50)
                            })
                            .padding(.top, 130)
                            .padding(.trailing, 15)
                            .opacity(currentIndex == gudangStories.count - 1 ? 0 : 1)
                        }
                    }
            }
            .opacity(isConversation ? 1 : 0)
//            TransitionOpening()
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            player.stopAudio()
            if isTapGestureEnabled {
                if currentIndex < gudangStories.count - 2 {
                    currentIndex += 1
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
                }
                else {
                    isTapGestureEnabled = false
                    matchManager.isFinishedReading += 1
                    matchManager.synchronizeGameState("ReadingSecond")
                    if matchManager.isFinishedReading == 2 {
//                        matchManager.gameStatus = .cameraGame
                        router.path.append(.cameraGame)
                    } else {
                        currentIndex += 1
                    }
                }
            }
        }
        .onAppear{
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

#Preview {
    GudangView()
        .environmentObject(MatchManager())
}
