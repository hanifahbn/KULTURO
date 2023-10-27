//
//  GudangStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 25/10/23.
//

import SwiftUI

struct  GudangStoriesView: View {
    @StateObject var viewModel : StoryViewModel
    @EnvironmentObject var router : Router
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    @State var isTapGestureEnabled = true
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
           
            Rectangle()
                .ignoresSafeArea()
                .zIndex(2)
                .opacity(viewModel.gudangStories[viewModel.currentIndex].transisiStories ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: viewModel.gudangStories[viewModel.currentIndex].transisiStories)
            Image(viewModel.gudangStories[viewModel.currentIndex].characterTwo)
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
                Image(viewModel.gudangStories[viewModel.currentIndex].characterOne)
                    .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(viewModel.gudangStories[viewModel.currentIndex].stories)
                                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                                    .padding(4)
                                Spacer()
                            }
                            Spacer()
                        }
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
                viewModel.currentIndex += 1
                if viewModel.currentIndex == 1{
                    isStory = false
                    
                } else if viewModel.currentIndex == 3{
                    isAnimation1 = true
                    isStory = false
                    isTapGestureEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        viewModel.currentIndex += 1
                        isAnimation = true
                        isAnimation1 = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isStory = true
                            isTapGestureEnabled = true
                        }
                    }
                    
                } else if viewModel.currentIndex == 7{
//
                    isAnimation1 = true
                    isStory = false
                    isTapGestureEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        viewModel.currentIndex += 1
                        isAnimation1 = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isStory = true
                            isTapGestureEnabled = true
                        }
                    }
                } else if viewModel.currentIndex == 9{
                    isStory = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        router.path.append(.cameraGame)
                    }
                }
            }
        }
        .onAppear{
            isStory = true
        }
        
    }
}

#Preview {
    GudangStoriesView(viewModel: StoryViewModel())
}
