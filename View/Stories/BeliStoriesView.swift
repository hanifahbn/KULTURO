//
//  BeliPeralatanStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 23/10/23.
////

import SwiftUI

struct  BeliStoriesView: View {
    @StateObject var viewModel : StoryViewModel = StoryViewModel()
    @EnvironmentObject var matchManager : MatchManager
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    @State var isTapGestureEnabled = true
    
    
    var body: some View {
        //        NavigationStack{
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Image("BackgroundPanglong")
                .resizable()
                .ignoresSafeArea()
            HStack{
                HStack(spacing : -30){
                    Image(viewModel.desaStories[0].characterOne)
                        .resizable()
                        .frame(width: 110, height: 226)
                    Image(viewModel.desaStories[0].characterTwo)
                        .resizable()
                        .frame(width: 110, height: 226)
                }.padding()
                    .offset(x: isAnimation ? -20 : -200, y: 200)
                    .animation(.linear(duration: 3), value: isAnimation)
                Image(viewModel.beliStories[0].characterOne)
                    .resizable()
                    .frame(width: 80, height: 170)
                    .padding(.top, 300)
                    .opacity(isAnimation1 ? 1 : 0)
            }
            VStack{
                Spacer()
                HStack{
                    Image(viewModel.beliStories[viewModel.currentIndex].characterOne)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(viewModel.beliStories[viewModel.currentIndex].stories)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding(15)
                                Spacer()
                            }
                            Spacer()
                        }
                        
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isStory ? 1 : 0)
            //                .animation(.linear(duration: 0.2), value: isStory)
            
        }
        .onAppear{
            isAnimation = true
            isTapGestureEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                isStory = true
                isTapGestureEnabled = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            if isTapGestureEnabled {
                if viewModel.currentIndex < 4{
                    viewModel.currentIndex += 1
                } else if viewModel.currentIndex == 4{
                    isNextStory = true
                    matchManager.isFinishedReading += 1
                    matchManager.synchronizeGameState("Reading")
                    if matchManager.isFinishedReading == 2 {
                        matchManager.gameStatus = .missionone
                    }
                    else{
                        viewModel.currentIndex += 1
                    }
                }
            }
            
        }
    }
}

#Preview {
    BeliStoriesView()
        .environmentObject(MatchManager())
}

