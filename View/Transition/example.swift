//
//  example.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 02/11/23.
//

import SwiftUI

struct example: View {
    @StateObject var viewModel : StoryViewModel = StoryViewModel()
    @EnvironmentObject var matchManager : MatchManager
    @State var isStory : Bool = false
    @State var isAnimation : Bool = false
    @State var isAnimation1 : Bool = false
    @State var isNextStory : Bool = false
    @State var isTapGestureEnabled = true
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
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
                    .opacity(isAnimation1 ? 1 : 0)
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
                        VStack{
                            HStack{
                                Text(viewModel.beliStories[viewModel.currentIndex].stories)
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
    }
}

#Preview {
    example()
}
