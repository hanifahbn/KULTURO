//
//  BalaiDesaView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct BalaiDesaView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel = TransitionViewModel()
    @State var player = PlayerViewModel()
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isSecondAnimation : Bool = false
    @State var isthirdAnimation : Bool = false
    @State var isAnimatedKepalaDesa : Bool = false
    @State var isTapGestureEnabled = false
    @State var isCharacterShown = true
    @State var currentIndex = 0
    @State var soundOnOff : Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
        ZStack{
            Image("BrokenBalaiDesa")
                .resizable()
                .ignoresSafeArea()
            //MARK: Animation
            HStack(spacing : -30){
                ZStack{
                    GifImage(chosenCharacters[0].gifImage!)
                        .frame(width: 200, height: 200)
                        .padding(.trailing, 50)
                    GifImage(chosenCharacters[1].gifImage!)
                        .frame(width: 200, height: 200)
                        .padding(.leading, 50)
                }
                .scaleEffect(x: isSecondAnimation ? -1 : 1, y : 1)
            }
            .padding(.top, 200)
            .offset(x: isFirstAnimation ? -40 : -300)
            .animation(.linear(duration: 2.5), value: isFirstAnimation)
            .opacity(isthirdAnimation ? 0 : 1)
            
            HStack{
                HStack(spacing : -20){
                    Image(chosenCharacters[0].fullImage)
                        .resizable()
                        .frame(width: 110, height: 224)
                        .opacity(isCharacterShown ? 1 : 0)
                    Image(chosenCharacters[1].fullImage)
                        .resizable()
                        .frame(width: 110, height: 224)
                        .opacity(isCharacterShown ? 1 : 0)
                }
                .opacity(isthirdAnimation ? 1 : 0)
                .offset(x: 20, y: 100)
                Image(characters[4].fullImage)
                    .resizable()
                    .opacity(isAnimatedKepalaDesa ? 0 : 1)
//                    .opacity(isConversation ? 0 : 1)
                    .frame(width: 100, height: 200)
                    .offset(y: 70)
            }
            
//            GifImage(characters[4].gifImage!)
//                .frame(width: 200, height: 230)
//                .padding(.leading, 50)
//                .offset(x:  isSecondAnimation ? geometry.size.width - 10 : geometry.size.width - 30, y: 100)
//                .animation(.linear(duration: 1.5), value: isSecondAnimation)
//                .opacity(isAnimatedKepalaDesa ? 0 : 1)
//                .scaleEffect(x: -1, y : 1)
            TransitionOpening()
            TransitionClosing(viewModel: viewModel)
            VStack{
                Spacer()
                HStack{
                    Image(balaiDesaStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                Image("TextBoxStory")
                    .resizable()
                    .frame(width: geometry.size.width / 1, height: geometry.size.height / 3)
                    .overlay {
                        VStack(spacing : -15){
                            HStack{
                                Text("\(medanSuccessStories[currentIndex].isTalking.name)")
                                    .font(.custom("Chalkboard-Regular", size: 30))
                                    .foregroundStyle(Color.darkRed)
                                
                                    .padding(geometry.size.width * 0.037)
                                Spacer()
                            }
                            HStack{
                                Text(balaiDesaStories[currentIndex].text)
                                    .font(.custom("Chalkboard-Regular", size: 30))
                                    .foregroundStyle(.black)
                                    .padding(geometry.size.width * 0.025)
                                    .onAppear{
                                        if currentIndex == 0 {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                                player.playMultipleSound(fileName: balaiDesaStories[currentIndex].audioURL!)
                                            }
                                        }
                                        else {
                                            player.playMultipleSound(fileName: balaiDesaStories[currentIndex].audioURL!)
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
//                                    player.playAudioStory(fileName: balaiDesaStories[currentIndex].audioURL!)
                                player.playMultipleSound(fileName: balaiDesaStories[currentIndex].audioURL!)
//                                }
//                                soundOnOff.toggle()
                            }, label: {
                                Image("BackgroundButtonSound")
                                    .overlay{
                                        Image(soundOnOff ? "SoundOff" : "SoundOn")
                                    }
                            })
                            .padding(.top, 130)
                            .padding(geometry.size.width * 0.06)
                        }
                    }
                
            }
            .opacity(isConversation ? 1 : 0)
            //MARK: Transition
            
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //MARK: Nanti pindah ke view model
            if isTapGestureEnabled {
                if currentIndex < balaiDesaStories.count - 1 {
                    currentIndex += 1
                    player.playMultipleSound(fileName: balaiDesaStories[currentIndex].audioURL!)
//                    player.playAudioStory(fileName: balaiDesaStories[currentIndex].audioURL!)
                    //MARK: tidak perlu lagi
//                    if balaiDesaStories[currentIndex].text == "" {
//                        isCharacterShown = true
//                        isAnimatedKepalaDesa = false
//                        isConversation = false
//                        isSecondAnimation = true
//                        isTapGestureEnabled = false
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                            currentIndex += 1
//                            isAnimatedKepalaDesa = true
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                                isConversation = true
//                                isTapGestureEnabled = true
//                                isCharacterShown = false
//                            }
//                            
//                        }
//                    }
                    //MARK: =========
                }
                else {
                    isConversation = false
                    isTapGestureEnabled = false
                    isSecondAnimation = true
                    player.playAudioLoop(fileName: "backsound-village")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

                        isConversation = false
                        isthirdAnimation = false
                        isCharacterShown = false
                        isAnimatedKepalaDesa = false
                        isFirstAnimation = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            viewModel.startTransition()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                matchManager.gameStatus = .storyToko
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            player.playAudioLoop(fileName: "backsound-village")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                player.playAudioLoop(fileName: "backsound-village", volume: 0.06)
            }

            isFirstAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isthirdAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isConversation = true
                    isTapGestureEnabled = true
                    isConversation = true
                    isCharacterShown = false
                    isAnimatedKepalaDesa = true
                    
                }
            }
        }
    }
    }
}

#Preview {
    BalaiDesaView()
        .environmentObject(MatchManager())
}
