//
//  GudangStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 25/10/23.
//

import SwiftUI

struct  GudangStoriesView: View {
    @StateObject var viewModel : StoryViewModel
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(viewModel.gudangStories[viewModel.currentIndex].transisiStories ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: viewModel.gudangStories[viewModel.currentIndex].transisiStories)
            Image("BrokenBalaiDesa")
                .resizable()
                .ignoresSafeArea()
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
            Image(viewModel.gudangStories[3].characterOne)
                .resizable()
                .frame(width: 110, height: 226)
                .offset(x: 100, y: 100)
                .opacity(isAnimation ? 1 : 0)
            VStack{
                Spacer()
                HStack{
                    Image(viewModel.gudangStories[viewModel.currentIndex].characterOne)
                }
                .padding(.bottom, -200)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        Text(viewModel.gudangStories[viewModel.currentIndex].stories)
                            .font(.system(size: 28, weight: .medium, design: .rounded))
                            .padding(4)
                    }
                    .frame(width: 350, height: 200)
            }
            .opacity(isStory ? 1 : 0)
            //            .animation(.linear(duration: 0.2), value: isStory)
        }
        .onTapGesture {
            //Nanti di pindah ke view model
            viewModel.currentIndex += 1
            if viewModel.currentIndex == 1{
                isStory = false
               
            } else if viewModel.currentIndex == 3{
                isAnimation1 = true
                isStory = false
            } else if viewModel.currentIndex == 4{
                isAnimation = true
                isAnimation1 = false
            } else if viewModel.currentIndex == 8{
                isStory = false
            }
            else {
                isStory = true
            }
        }
        .onAppear{
            isStory = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//                
//            }
        }
        
    }
}

#Preview {
    GudangStoriesView(viewModel: StoryViewModel())
}
