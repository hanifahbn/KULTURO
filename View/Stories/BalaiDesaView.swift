//
//  BalaiDesaView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct BalaiDesaView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @State var isConversation : Bool = false
    @State var isFirstAnimation : Bool = false
    @State var isSecondAnimation : Bool = false
    @State var isGoingToNextView : Bool = false
    @State var isTapGestureEnabled = false
    @State var isCharacterShown = true
    @State var currentIndex = 0

    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(isGoingToNextView ? 1 : 0)
                .animation(.easeIn(duration: 1), value: isGoingToNextView)
            Image("BrokenBalaiDesa")
                .resizable()
                .ignoresSafeArea()
            HStack{
                HStack(spacing : -30){
                    Image(chosenCharacters[0].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                        .padding(.top, 40)
                        .opacity(isCharacterShown ? 1 : 0)
                    Image(chosenCharacters[1].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                        .opacity(isCharacterShown ? 1 : 0)
                    Spacer()
                    Image(characters[4].fullImage)
                        .resizable()
                        .opacity(isSecondAnimation ? 1 : 0)
                        .frame(width: 110, height: 226)
                        .offset(x: isSecondAnimation ?  0 : 100)
                        .animation(.linear(duration: 1.5), value: isSecondAnimation)
                        .opacity(isCharacterShown ? 1 : 0)

                }
                .padding(.top, 200)
                .offset(x: isFirstAnimation ? 10 : -200)
                .animation(.linear(duration: 2.5), value: isFirstAnimation)
            }
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
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding(15)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isConversation ? 1 : 0)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            if isTapGestureEnabled {
                if currentIndex < balaiDesaStories.count - 1 {
                    currentIndex += 1
                    if balaiDesaStories[currentIndex].text == "" {
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
                    isConversation = false
                    isTapGestureEnabled = false
                    isCharacterShown = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isFirstAnimation = false
                        isSecondAnimation = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isGoingToNextView = true
                            matchManager.gameStatus = .storyToko
                        }
                    }
                }
            }
        }
        .onAppear{
            isFirstAnimation = true
            isSecondAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                isConversation = true
                isTapGestureEnabled = true
                isConversation = true
                isCharacterShown = false
            }
        }

    }
}

#Preview {
    BalaiDesaView()
        .environmentObject(MatchManager())
}
