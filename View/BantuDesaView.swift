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
    @State var isPakDesaAnimation : Bool = false
    @State var isTapGestureEnabled = true
    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Image(viewModel.bantuDesaStories[viewModel.currentIndex].characterTwo)
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
                Image("HeadOffice")
                    .resizable()
                    .frame(width: 110, height: 226)
                    .offset(x: 10, y: 10)
                    .opacity(isPakDesaAnimation ? 0 : 1)
                Spacer()
            }
            .padding(.top, 200)
            .offset(x: isAnimation1 ? -250 : 60)
            .animation(.linear(duration: 2),value: isAnimation1)
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
                        VStack{
                            HStack{
                                Text(viewModel.bantuDesaStories[viewModel.currentIndex].stories)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding(16)
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
            isStory = true
            isPakDesaAnimation = true
            matchManager.isFinishedPlaying = 0
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            //Nanti di pindah ke view model
            if isTapGestureEnabled{
                if viewModel.currentIndex < 8 {
                    viewModel.currentIndex += 1
                } else {
                    isTapGestureEnabled = false
                    matchManager.isFinishedReading += 1
                    matchManager.synchronizeGameState("ReadingThird")
                    if matchManager.isFinishedReading == 2 {
                        matchManager.gameStatus = .dragAndDrop
                    }
                }
                if viewModel.currentIndex == 2 {
                    isAnimation = true
                   
                    print(viewModel.currentIndex)
                } else if viewModel.currentIndex == 3{
                   isPakDesaAnimation = false
                    isAnimation1 = true
                    isStory = false
                    isTapGestureEnabled = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        viewModel.currentIndex += 1
                        isAnimation1 = false
                        
                        print(viewModel.currentIndex)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            isStory = true
                            isAnimation = false
                            isTapGestureEnabled = true
                            matchManager.gameStatus = .dragAndDrop
                        }
                    }
                }
            }
        }
    }
    
}
    
    
    
    #Preview {
        BantuDesaView()
            .environmentObject(MatchManager())
    }
    
    //if isTapGestureEnabled{
    //    viewModel.currentIndex += 1
    //    if viewModel.currentIndex == 1{
    //        if viewModel.currentIndex < 7 {
    //            viewModel.currentIndex += 1
    //        }  else if viewModel.currentIndex == 3{
    //            isStory = false
    //        } else if viewModel.currentIndex == 4{
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    //                isStory = true
    //            } else if viewModel.currentIndex == 3{
    //                isAnimation1 = true
    //                isStory = false
    //                isTapGestureEnabled = false
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //                    viewModel.currentIndex += 1
    //                    isAnimation1 = false
    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
    //                        isStory = true
    //                        isTapGestureEnabled = true
    //                    }
    //                }
    //            } else if viewModel.currentIndex == 7{
    //                //router.path.append(.dragGame)
    //            }
    //        }
    //    }
    //
    //}
    
    
    //                        matchManager.gameStatus = .convoPasir
