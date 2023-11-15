//
//  BalaiDesaRenovatedView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct BalaiDesaRenovatedView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @State var player = PlayerViewModel()
    @State var isGoingToNextView : Bool = false
    @State var isTapGestureEnabled = true
    @State var currentIndex = 0

    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
//            Rectangle()
//                .ignoresSafeArea()
//                .zIndex(1)
//                .opacity(isGoingToNextView ? 1 : 0)
//                .animation(.easeIn(duration: 1), value: isGoingToNextView)
            Image("BalaiDesaRenovated")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Image(medanSuccessStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                Image("TextBoxStory")
                    .resizable()
                    .frame(width: 360, height: 250)
                    .overlay {
                        VStack{
                            HStack{
                                Text(medanSuccessStories[currentIndex].text)
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
                                player.playAudioStory(fileName: medanSuccessStories[currentIndex].audioURL!)
                            }, label: {
                                Image("IconButtonSpeaker")
                                    .resizable()
                                    .frame(width: 70, height: 50)
                            })
                            .padding(.top, 130)
                            .padding(.trailing, 15)
//                            .opacity(currentIndex == medanSuccessStories.count - 1 ? 0 : 1)
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            player.stopAudio()
            if isTapGestureEnabled {
                if currentIndex < medanSuccessStories.count - 1 {
                    currentIndex += 1
                }
                else {
                    isTapGestureEnabled = false
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isGoingToNextView = true
                        matchManager.gameStatus = .ending
//                    }
                }
            }
        }
        .onAppear{
            matchManager.stopTimer()
        }

    }
}

#Preview {
    BalaiDesaRenovatedView()
        .environmentObject(MatchManager())
}
