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
    @State var soundOnOff : Bool = false
    
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
                                    Text(medanSuccessStories[currentIndex].text)
                                        .font(.custom("Chalkboard-Regular", size: 30))
                                        .foregroundStyle(.black)
                                        .padding(geometry.size.width * 0.025)
                                        .onAppear{
                                            player.playAudioStory(fileName: medanSuccessStories[currentIndex].audioURL!)
                                        }
                                    Spacer()
                                }
//                                .background(Color.red)
                                Spacer()
                            }
                            .padding()
                            HStack{
                                Spacer()
                                Button(action: {
                                    
                                    player.playAudioStory(fileName: medanSuccessStories[currentIndex].audioURL!)
                                    
                                }, label: {
                                    Image("BackgroundButtonSound")
                                        .overlay{
                                            Image("SoundOn")
                                        }
                                })
                                .padding(.top, 130)
                                .padding(geometry.size.width * 0.06)
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
                        player.playAudioStory(fileName: medanSuccessStories[currentIndex].audioURL!)
                    }
                    else {
                        isTapGestureEnabled = false
                        isGoingToNextView = true
                        matchManager.gameStatus = .ending
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
