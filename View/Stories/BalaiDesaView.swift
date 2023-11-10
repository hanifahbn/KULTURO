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
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isSecondAnimation : Bool = false
    @State var isthirdAnimation : Bool = false
    @State var isAnimatedKepalaDesa : Bool = false
    @State var isTapGestureEnabled = false
    @State var isCharacterShown = true
    @State var currentIndex = 0
    
    var body: some View {
        ZStack{
            Image("BrokenBalaiDesa")
                .resizable()
                .ignoresSafeArea()
            //MARK: Animation
            HStack(spacing : -30){
                ZStack{
                    GifImage("AnimationAsep")
                        .frame(width: 200, height: 200)
                        .padding(.trailing, 50)
                    GifImage("AnimationTogar")
                        .frame(width: 200, height: 200)
                        .padding(.leading, 50)
                }
                .scaleEffect(x: isSecondAnimation ? -1 : 1, y : 1)
            }
            .padding(.top, 200)
            .offset(x: isFirstAnimation ? 0 : -300)
            .animation(.linear(duration: 2.5), value: isFirstAnimation)
            .opacity(isthirdAnimation ? 0 : 1)
            HStack{
                HStack(spacing : -40){
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
                .offset(x: 40, y: 100)
                Image(characters[4].fullImage)
                    .resizable()
                    .opacity(isAnimatedKepalaDesa ? 1 : 0)
                    .opacity(isConversation ? 0 : 1)
                    .frame(width: 100, height: 200)
                    .offset(y: 70)
            }
            GifImage("AnimationKepalaDesa")
                .frame(width: 200, height: 230)
                .padding(.leading, 50)
                .offset(x:  isSecondAnimation ? -120 : -300, y: 100)
                .animation(.linear(duration: 1.5), value: isSecondAnimation)
                .opacity(isAnimatedKepalaDesa ? 0 : 1)
                .scaleEffect(x: -1, y : 1)
            VStack{
                Spacer()
                HStack{
                    Image(balaiDesaStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(balaiDesaStories[currentIndex].text)
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
            //MARK: Transition
            TransitionOpening()
            TransitionClosing(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //MARK: Nanti pindah ke view model
            if isTapGestureEnabled {
                if currentIndex < balaiDesaStories.count - 1 {
                    currentIndex += 1
                    if balaiDesaStories[currentIndex].text == "" {
                        isCharacterShown = true
                        isAnimatedKepalaDesa = false
                        isConversation = false
                        isSecondAnimation = true
                        isTapGestureEnabled = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            currentIndex += 1
                            isAnimatedKepalaDesa = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                isConversation = true
                                isTapGestureEnabled = true
                                isCharacterShown = false
                            }
                            
                        }
                    }
                }
                else {
                    isConversation = false
                    isTapGestureEnabled = false
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isConversation = false
                        isthirdAnimation = false
                        isCharacterShown = false
                        isAnimatedKepalaDesa = false
                        isAnimatedKepalaDesa = true
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
            isFirstAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isthirdAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isConversation = true
                    isTapGestureEnabled = true
                    isConversation = true
                    isCharacterShown = false
                    
                }
            }
        }
        
    }
}

#Preview {
    BalaiDesaView()
        .environmentObject(MatchManager())
}
