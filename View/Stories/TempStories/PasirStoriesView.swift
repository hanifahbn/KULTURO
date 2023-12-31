//
//  PasirStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 25/10/23.
//

import SwiftUI

struct  PasirStoriesView: View {
    @EnvironmentObject var matchManager: MatchManager
    
//    @StateObject var viewModel : StoryViewModel = StoryViewModel()
    @State private var currentIndex = 0
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Image("BrokenBalaiDesa")
                .resizable()
                .ignoresSafeArea()
//            Rectangle()
//                .ignoresSafeArea()
//                .zIndex(1)
//                .opacity(viewModel.pasirStories[viewModel.currentIndex].transisiStories ? 1 : 0)
//                .animation(.easeIn(duration: 0.5), value: viewModel.pasirStories[viewModel.currentIndex].transisiStories)
            HStack(spacing : -30){
                Image(chosenCharacters[0].fullImage)
                    .resizable()
                    .frame(width: 110, height: 226)
                    .padding(.top, 40)
                Image(chosenCharacters[0].fullImage)
                    .resizable()
                    .frame(width: 110, height: 226)
                Spacer()
            }
            .padding(.top, 200)
            .offset(x: isAnimation1 ? -250 : 60)
            .animation(.linear(duration: 2),value: isAnimation1)
            .opacity(isAnimation ? 1 : 0)
            VStack{
                Spacer()
                HStack{
                    Image(pasirStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        HStack{
                            VStack{
                                Text(pasirStories[currentIndex].text)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding(16)
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isStory ? 1 : 0)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            if currentIndex < 4 {
                currentIndex += 1
            } else {
                matchManager.isFinishedReading += 1
                matchManager.synchronizeGameState("ReadingFourth")
                if matchManager.isFinishedReading == 2 {
                    matchManager.gameStatus = .shakeGame
                }
            }
            
            if currentIndex == 0{
                isStory = false
                isAnimation = false
            }
        }
        .onAppear{
            matchManager.isFinishedPlaying = 0
            isStory = true
            matchManager.stopTimer()
        }
    }
}

#Preview {
    PasirStoriesView()
        .environmentObject(MatchManager())
}
