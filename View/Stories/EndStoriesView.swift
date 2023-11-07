//
//  EndStories.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 25/10/23.
//
import SwiftUI

struct  EndStoriesView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @StateObject var viewModel : StoryViewModel = StoryViewModel()
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
            Rectangle()
                .ignoresSafeArea()
                .opacity(viewModel.endStories[viewModel.currentIndex].transisiStories ? 0.4 : 0)
                .padding(.top, 200)
                .opacity(viewModel.endStories[viewModel.currentIndex].transisiStories ? 0 : 1)
            if viewModel.endStories[viewModel.currentIndex].transisiStories {
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.white)
                        .shadow(radius: 0, y: 5)
                        .opacity(0.8)
                        .overlay {
                            HStack{
                                VStack{
                                    if(!chosenCharacters.isEmpty){
                                        Text(endStories[viewModel.currentIndex].text)
                                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                                            .padding(25)
                                    } else{
                                        Text(endStories[viewModel.currentIndex].text)
                                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                                            .padding(25)
                                    }
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                            
                        }
                        .frame(width: 350, height: 350)
                    
                }
            } else {
                VStack{
                    Spacer()
                    HStack{
                        Image(endStories[viewModel.currentIndex].isTalking.halfImage)
                    }
                    .padding(.bottom, -300)
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.white)
                        .shadow(radius: 0, y: 5)
                        .overlay {
                            HStack{
                                VStack{
                                    if(!chosenCharacters.isEmpty){
                                        Text(endStories[viewModel.currentIndex].text)
                                            .font(.system(size: 25, weight: .medium, design: .rounded))
                                            .padding(15)
                                    } else {
                                        Text(endStories[viewModel.currentIndex].text)
                                            .font(.system(size: 25, weight: .medium, design: .rounded))
                                            .padding(15)
                                    }
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                            
                        }
                        .frame(width: 350, height: 200)
                }
            }
        }
        .onAppear{
            matchManager.isFinishedPlaying = 0
            matchManager.stopTimer()
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            viewModel.currentIndex += 1
        }
    }
}

#Preview {
    EndStoriesView()
        .environmentObject(MatchManager())
}


