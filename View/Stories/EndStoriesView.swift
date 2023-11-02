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
                                    if(!matchManager.chosenCharacters.isEmpty){
                                        Text(viewModel.endStories[viewModel.currentIndex].stories.replacingOccurrences(of: "nama1", with: matchManager.chosenCharacters[0].name).replacingOccurrences(of: "nama2", with: matchManager.chosenCharacters[1].name))
                                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                                            .padding(25)
                                    } else{
                                        Text(viewModel.endStories[viewModel.currentIndex].stories.replacingOccurrences(of: "nama1", with: "Asep").replacingOccurrences(of: "nama2", with: "Togar"))
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
                        Image(viewModel.endStories[viewModel.currentIndex].characterOne)
                    }
                    .padding(.bottom, -300)
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.white)
                        .shadow(radius: 0, y: 5)
                        .overlay {
                            HStack{
                                VStack{
                                    if(!matchManager.chosenCharacters.isEmpty){
                                        Text(viewModel.endStories[viewModel.currentIndex].stories.replacingOccurrences(of: "nama1", with: matchManager.chosenCharacters[0].name).replacingOccurrences(of: "nama2", with: matchManager.chosenCharacters[1].name))
                                            .font(.system(size: 25, weight: .medium, design: .rounded))
                                            .padding(15)
                                    } else {
                                        Text(viewModel.endStories[viewModel.currentIndex].stories.replacingOccurrences(of: "nama1", with: "Asep").replacingOccurrences(of: "nama2", with: "Togar"))
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
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            viewModel.currentIndex += 1
        }
    }
}

//#Preview {
//    EndStoriesView()
//        .environmentObject(MatchManager())
//}

