//
//  BeliPeralatanStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 23/10/23.
//

import SwiftUI

struct  BeliStoriesView: View {
    @StateObject var viewModel : StoryViewModel
    @StateObject var matchManager : MatchManager
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    var body: some View {
//        NavigationStack{
            ZStack{
                // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
                Rectangle()
    //                .foregroundStyle(.white)
                    .ignoresSafeArea()
                    .zIndex(1)
                    .opacity(isNextStory ? 1 : 0)
                    .animation(.easeIn(duration: 0.5), value: isNextStory)
                    Image("BackgroundImage")
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
                    }.padding(.top, 200)
                        .offset(x: isAnimation ? 10 : -200)
                        .animation(.linear(duration: 3), value: isAnimation)
                    Image(viewModel.beliStories[0].characterOne)
                        .resizable()
                        .frame(width: 80, height: 170)
                        .padding(.top, 150)
                }
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.white)
                        .opacity(0.8)
                        .shadow(radius: 0, y: 5)
                        .overlay {
                            Text(viewModel.beliStories[viewModel.currentIndex].stories)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .padding()
                                
                        }
                        .frame(width: 400, height: 200)
                   
                    HStack(spacing : -200){
                        Image(viewModel.beliStories[viewModel.currentIndex].characterOne)
                        
                        if viewModel.currentIndex % 2 != 0{
                            Image(viewModel.beliStories[viewModel.currentIndex].characterTwo)
                        }
                    }
                    .padding(.bottom, -100)
                }
                .opacity(isStory ? 1 : 0)
//                .animation(.linear(duration: 0.2), value: isStory)
            }
            .onTapGesture {
                //Nanti di pindah ke view model
                viewModel.currentIndex += 1
                if viewModel.currentIndex == 5{
                    matchManager.gameStatus = .missionone
                }
            }
            .onAppear{
                isAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    isStory = true
                }
            }
//        }
        
    }
}

#Preview {
    BeliStoriesView(viewModel: StoryViewModel(), matchManager: MatchManager())
}
