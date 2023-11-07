//
//  GudangStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 25/10/23.
//

import SwiftUI

struct  GudangStoriesView: View {
    @EnvironmentObject var matchManager: MatchManager
    @StateObject var viewModel : StoryViewModel = StoryViewModel()
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    @State var isTapGestureEnabled = true
    @State var isPakDesaHilang : Bool = false
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(isNextStory ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: isNextStory)
            if viewModel.currentIndex > 2{
                Image("BrokenBalaiDesa")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image("BackgroundPanglong")
                    .resizable()
                    .ignoresSafeArea()
            }
            HStack(spacing : -30){
                Image(characters[0].fullImage)
                    .resizable()
                    .frame(width: 110, height: 226)
                    .padding(.top, 40)
                Image(characters[1].fullImage)
                    .resizable()
                    .frame(width: 110, height: 226)
                Spacer()
            }
            .padding(.top, 200)
            .offset(x: isAnimation1 ? -250 : 60, y: 60)
            .animation(.linear(duration: 2),value: isAnimation1)
            .opacity(isAnimation ? 1 : 0)
            Image(characters[4].fullImage)
                .resizable()
                .frame(width: 110, height: 226)
                .offset(x: 100, y: 120)
                .opacity(isPakDesaHilang ? 1 : 0)
            VStack{
                Spacer()
                Image(gudangStories[viewModel.currentIndex].isTalking.halfImage)
                    .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(gudangStories[viewModel.currentIndex].text)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding(16)
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isStory ? 1 : 0)
            //            .animation(.linear(duration: 0.2), value: isStory)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            if isTapGestureEnabled{
                if(viewModel.currentIndex < 9) {
                    viewModel.currentIndex += 1
                }
                else{
                    isTapGestureEnabled = false
                    matchManager.isFinishedReading += 1
                    matchManager.synchronizeGameState("ReadingSecond")
                    if matchManager.isFinishedReading == 1 {
                        matchManager.gameStatus = .cameraGame
                    }
                }
                
                if viewModel.currentIndex == 0 {
                    isStory = false
                } else if viewModel.currentIndex == 2{
                    isAnimation1 = true
                    isStory = false
                    isTapGestureEnabled = false
                    isNextStory = true
                    isAnimation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isNextStory = false
                        viewModel.currentIndex += 1
                        isAnimation = true
                        isAnimation1 = false
                        isStory = false
                        isPakDesaHilang = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.currentIndex += 1
                            isStory = true
                            isTapGestureEnabled = true
                            isAnimation = false
                            isPakDesaHilang = false
                        }
                    }
                } else if viewModel.currentIndex == 7 {
                    isStory = false
                    isNextStory = true
                    isAnimation1 = true
                    isPakDesaHilang = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isNextStory = false
                        viewModel.currentIndex += 1
                        isAnimation = true
                        isAnimation1 = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isStory = true
                            isPakDesaHilang = false
                        }
                    }
                }
            }
        }
        .onAppear{
            isStory = true
            matchManager.isFinishedPlaying = 0
            matchManager.isFinishedReading = 0
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            //
            //            }
        }
        
    }
}

#Preview {
    GudangStoriesView(viewModel: StoryViewModel())
        .environmentObject(MatchManager())
}
