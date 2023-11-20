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
        GeometryReader{ geometry in
            ZStack{
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
//                        .frame(width: 360, height: 250)
                        .frame(width: geometry.size.width * 1, height: geometry.size.height / 3)
                        .overlay {
                            VStack{
                                HStack{
                                    Text(medanSuccessStories[currentIndex].text)
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(.black)
                                        .padding(geometry.size.width * 0.066)
                                        
                                        .onAppear{
                                            player.playAudioStory(fileName: medanSuccessStories[currentIndex].audioURL!)
                                        }
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                            HStack{
                                Spacer()
                                Button(action: {
                                    if player.player!.isPlaying {
                                        player.stopAudio()
                                    } else {
                                        player.playAudioStory(fileName: medanSuccessStories[currentIndex].audioURL!)
                                    }
                                }, label: {
                                    Image("IconButtonSpeaker")
                                        .resizable()
                                        .frame(width: 70, height: 50)
                                })
                                .padding(geometry.size.width * 0.066)
                                
                                .padding(.top, 130)
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
}

#Preview {
    BalaiDesaRenovatedView()
        .environmentObject(MatchManager())
}
