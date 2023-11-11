//
//  BeliPeralatanStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 23/10/23.
////

import SwiftUI

struct  BeliStoriesView: View {
//    @StateObject var viewModel : StoryViewModel = StoryViewModel()
    @EnvironmentObject var matchManager : MatchManager
    @State private var currentIndex = 0
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
                    Image(characters[0].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                    Image(characters[1].fullImage)
                        .resizable()
                        .frame(width: 110, height: 226)
                }.padding()
                    .offset(x: isAnimation ? 20 : -200, y: 240)
                    .animation(.linear(duration: 3), value: isAnimation)
                Image(characters[5].fullImage)
                    .resizable()
                    .frame(width: 80, height: 170)
                    .padding(.top, 300)
                    
            }
            .opacity(isAnimation1 ? 0 : 1)
            VStack{
                Spacer()
                HStack{
                    Image(beliStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(beliStories[currentIndex].text)
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
                if currentIndex < 3{
                    currentIndex += 1
                    isAnimation1 = true
                } else if currentIndex == 3{
                    isNextStory = true
                    matchManager.isFinishedReading += 1
                    matchManager.synchronizeGameState("Reading")
                    if matchManager.isFinishedReading == 2 {
                        matchManager.gameStatus = .soundGame
                        print("Masuk misi")
                    }
                    else{
                        currentIndex += 1
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

