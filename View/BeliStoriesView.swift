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
                
                ZStack{
                    Rectangle()
        //                .foregroundStyle(.white)
                        .ignoresSafeArea()
                        .opacity(isNextStory ? 0.5 : 0)
                    Text(isNextStory ?  viewModel.beliStories[viewModel.currentIndex].stories : "")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
                .animation(.easeIn(duration: 0.5), value: isNextStory)
                .zIndex(2)
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
                            Text(viewModel.beliStories[viewModel.currentIndex].stories)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .padding()
                                
                        }
                        .frame(width: 350, height: 200)
                }
                .opacity(isStory ? 1 : 0)
//                .animation(.linear(duration: 0.2), value: isStory)
                
            }
            .onTapGesture {
                //Nanti di pindah ke view model
                viewModel.currentIndex += 1
                if viewModel.currentIndex == 5{
                    isStory = false
                    isNextStory = true
                    
                } else if viewModel.currentIndex == 6{
                    isNextStory = true
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
