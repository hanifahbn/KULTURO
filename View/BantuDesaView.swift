//
//  DragDropView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 25/10/23.
//

import SwiftUI

struct  BantuDesaView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @StateObject var viewModel : StoryViewModel = StoryViewModel()
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
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(viewModel.bantuDesaStories[viewModel.currentIndex].transisiStories ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: viewModel.bantuDesaStories[viewModel.currentIndex].transisiStories)
            HStack(spacing : -30){
                Image(viewModel.desaStories[0].characterOne)
                    .resizable()
                    .frame(width: 110, height: 226)
                    .padding(.top, 40)
                Image(viewModel.desaStories[0].characterTwo)
                    .resizable()
                    .frame(width: 110, height: 226)
                Spacer()
            }
            .padding(.top, 200)
            .offset(x: isAnimation1 ? -250 : 60)
            .animation(.linear(duration: 2),value: isAnimation1)
            Image(viewModel.bantuDesaStories[3].characterOne)
                .resizable()
                .frame(width: 110, height: 226)
                .offset(x: 100, y: 100)
                .opacity(isAnimation ? 1 : 0)
            VStack{
                Spacer()
                HStack{
                    Image(viewModel.bantuDesaStories[viewModel.currentIndex].characterOne)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        Text(viewModel.bantuDesaStories[viewModel.currentIndex].stories)
                            .font(.system(size: 28, weight: .medium, design: .rounded))
                            .padding(4)
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isStory ? 1 : 0)
            //            .animation(.linear(duration: 0.2), value: isStory)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            if viewModel.currentIndex < 7 {
                viewModel.currentIndex += 1
            } else {
                matchManager.gameStatus = .convoPasir
            }
            
            if viewModel.currentIndex == 1{
                isStory = false
            } else if viewModel.currentIndex == 3{
                isStory = false
            } else if viewModel.currentIndex == 4{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isStory = true
                }
            } else if viewModel.currentIndex == 7{
//                router.path.append(.dragGame)
            }
        }
        .onAppear{
            isStory = true
            
        }
        
    }
}

#Preview {
    BantuDesaView()
        .environmentObject(MatchManager())
}
