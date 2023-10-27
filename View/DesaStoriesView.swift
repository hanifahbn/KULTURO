//
//  DesaStoriesView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 21/10/23.
//

import SwiftUI

struct DesaStoriesView: View {
    @StateObject var viewModel : StoryViewModel
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    @EnvironmentObject var router : Router
    @State var isTapGestureEnabled = true
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(isNextStory ? 1 : 0)
                .animation(.easeIn(duration: 1), value: isNextStory)
            if viewModel.currentIndex >= 7{
                Image("BrokenBalaiDesa")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image("BackgroundImageGapura")
                    .resizable()
                    .ignoresSafeArea()
            }
            HStack{
                HStack(spacing : -30){
                    Image(viewModel.desaStories[0].characterOne)
                        .resizable()
                        .frame(width: 110, height: 226)
                        .padding(.top, 40)
                    Image(viewModel.desaStories[0].characterTwo)
                        .resizable()
                        .frame(width: 110, height: 226)
                    Spacer()
                    Image(viewModel.desaStories[4].characterTwo)
                        .resizable()
                        .opacity(isAnimation1 ? 1 : 0)
                        .frame(width: 110, height: 226)
                        .offset(x: isAnimation1 ?  0 : 100)
                        .animation(.linear(duration: 1.5), value: isAnimation1)
                    
                }
                .padding(.top, 200)
                .offset(x: isAnimation ? 10 : -200)
                .animation(.linear(duration: 2.5), value: isAnimation)
            }
            //            .offset(x: isAnimation1 ? 400 : 0)
            
            VStack{
                Spacer()
                HStack{
                    Image(viewModel.desaStories[viewModel.currentIndex].characterOne)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(viewModel.desaStories[viewModel.currentIndex].stories)
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
            if isTapGestureEnabled {
                //Nanti di pindah ke view model
                viewModel.currentIndex += 1
                if viewModel.currentIndex == 4 {
                    isStory = false
                    isAnimation1 = true
                    isTapGestureEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isStory = true
                        isTapGestureEnabled = true
                    }
                } else if viewModel.currentIndex == 6 {
                    isStory = false
                    isAnimation = false
                    isAnimation1 = false
                    isNextStory = true
                    isTapGestureEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isNextStory = false
                        viewModel.currentIndex += 1
                        isStory = false
                        isAnimation1 = true
                        isAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            viewModel.currentIndex = 8
                            isStory = true
                            isTapGestureEnabled = true
                        }
                        
                    }
                } else if viewModel.currentIndex == 11 {
                    
                    isStory = false
                    isAnimation = false
//                    isAnimation1 = true
                    isNextStory = true
                    isTapGestureEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        router.path.append(.beliStories)
                    }
                }
            }
        }
        .onAppear{
            isAnimation = true
            isTapGestureEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                isStory = true
                isTapGestureEnabled = true
                
            }
        }
        
    }
}

#Preview {
    DesaStoriesView(viewModel: StoryViewModel())
}
