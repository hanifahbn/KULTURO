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
                Image("BackgroundPanglong")
                    .resizable()
                    .ignoresSafeArea()
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
                TransitionOpening()
                VStack{
                    Spacer()
                    HStack{
                        Image(tokoStories[currentIndex].isTalking.halfImage)
                    }
                    .padding(.bottom, -300)
                    Image("TextBoxStory")
                        .resizable()
                        .frame(width: geometry.size.width / 1, height: geometry.size.height / 3)
                        .overlay {
                            VStack(spacing : -15){
                                HStack{
                                    Text("\(tokoStories[currentIndex].isTalking.name)")
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(Color.darkRed)

                                        .padding(geometry.size.width * 0.037)
                                    Spacer()
                                }
                                HStack{
                                    Text(tokoStories[currentIndex].text)
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(.black)
                                        .padding(geometry.size.width * 0.025)
                                        .onAppear{
                                            if currentIndex == 0 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                                    player.playMultipleSound(fileName: tokoStories[currentIndex].audioURL!)
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

                                    player.playMultipleSound(fileName: tokoStories[currentIndex].audioURL!)

                                }, label: {
                                    Image("BackgroundButtonSound")
                                        .overlay{
                                            Image("SoundOn")
                                        }
                                })
                                .padding(.top, 130)
                                .padding(geometry.size.width * 0.06)
                                .opacity(currentIndex == tokoStories.count - 1 ? 0 : 1)
                            }
                        }
                    //                    .frame(width: 350, height: 200)
                }
                .opacity(isConversation ? 1 : 0)

            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                if isTapGestureEnabled {
                    if currentIndex < tokoStories.count - 2 {
                        currentIndex += 1
                        player.playMultipleSound(fileName: tokoStories[currentIndex].audioURL!)
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
                    //MARK: =========
                    }
                    else {
                        isTapGestureEnabled = false
                        matchManager.isFinishedReading += 1
                        matchManager.synchronizeGameState("Reading")
                        if matchManager.isFinishedReading == 2 {
                            matchManager.gameStatus = .soundGame
                        } else {
                            currentIndex += 1
                            player.playBacksoundOnly()
                        }
                    }
                }
            }
            .onAppear{
                player.playAudioLoop(fileName:"backsound-store")

                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    player.playAudioLoop(fileName:"backsound-store", volume: 0.5)
                }

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
}

#Preview {
    TokoView()
        .environmentObject(MatchManager())
}
