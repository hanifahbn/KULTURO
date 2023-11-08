//
//  GudangView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct GudangView: View {
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
            Image("BackgroundGudang")
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
                    .offset(x: isFirstAnimation ? 20 : -200, y: 240)
                    .animation(.linear(duration: 3), value: isFirstAnimation)
                Image(characters[4].fullImage)
                    .resizable()
                    .frame(width: 80, height: 170)
                    .padding(.top, 300)
                    
            }
            .opacity(isCharacterShown ? 1 : 0)
            VStack{
                Spacer()
                HStack{
                    Image(gudangStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(gudangStories[currentIndex].text)
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
                if currentIndex < gudangStories.count - 1 {
                    currentIndex += 1
                    if gudangStories[currentIndex].text == "" {
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
                    matchManager.synchronizeGameState("ReadingSecond")
                    if matchManager.isFinishedReading == 2 {
                        matchManager.gameStatus = .cameraGame
                    }
                }
            }
        }
        .onAppear{
            isFirstAnimation = true
            isSecondAnimation = true
            matchManager.stopTimer()
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
    GudangView()
        .environmentObject(MatchManager())
}
