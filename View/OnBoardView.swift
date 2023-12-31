//
//  onBoardView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct OnBoardView: View {
    @EnvironmentObject var matchManager : MatchManager
    @State var offsetAnimation : Double = 0.8
    @State var ScaletAnimation : Double = 1
    @State var HomeAnimation : CGFloat = 1.3 /*600*/
    @State var isAnimation : Bool = false
    @State var isOpacity : Bool = false
    @State var offseYSky : CGFloat = 0.0 /* 0.0*/
    @State var offseYCloud : CGFloat = 0.4 /* 0.0*/
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("SkyOnboard")
                    .resizable()
                    .ignoresSafeArea()
                ZStack{
                    HStack{
                        Spacer()
                        Image("Cloud2OnBoard")
                            .resizable()
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height / 6)
                            .padding(.bottom, geometry.size.width * 1.6)
                            .scaleEffect(ScaletAnimation)
                            .animation(.linear(duration: 25).repeatForever(autoreverses: true), value: ScaletAnimation)
                    }
                    
                    Image("Cloud3OnBoard")
                        .resizable()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 5.5)
                        .padding(.bottom, geometry.size.width * 2)
                        .offset(x: -geometry.size.width * offsetAnimation)
                        .animation(.linear(duration: 10).repeatForever(autoreverses: true), value: offsetAnimation)
                    
                    Image("Cloud3OnBoard")
                        .resizable()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 7)
                        .padding(.bottom, geometry.size.width * 0.7)
                        .offset(x: geometry.size.width * offsetAnimation)
                        .animation(.linear(duration: 10).repeatForever(autoreverses: true), value: offsetAnimation)
                    Spacer()
                    HStack{
                        Image("CloudOnBoard")
                            .resizable()
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height / 6)
                            .padding(.bottom, geometry.size.width * 1)
                            .scaleEffect(ScaletAnimation)
                            .animation(.linear(duration: 20).repeatForever(autoreverses: true), value: ScaletAnimation)
                        Spacer()
                        
                    }
                    Image("AppName")
                        .resizable()
                    
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.height / 5)
                        .padding(.bottom, geometry.size.width * 1.4)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .offset(y : -geometry.size.width * offseYSky)
                .animation(.easeInOut(duration: 2), value: offseYSky)
                ZStack{
                    HStack{
                        Image("CloudOnBoard")
                            .resizable()
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height / 6)
                            .padding(.bottom, geometry.size.width * 0.75)
                            .offset(x: -geometry.size.width * offseYCloud)
                            .animation(.linear(duration: 10), value: offseYCloud)
                            .scaleEffect(2)
                        Image("CloudOnBoard")
                            .resizable()
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height / 6)
                            .padding(.bottom, geometry.size.width * 0.85)
                            .offset(x: -geometry.size.width * offseYCloud)
                            .animation(.linear(duration: 10), value: offseYCloud)
                            .scaleEffect(2)
                            .scaleEffect(x : -1 )
                        
                    }
                    
                    Image("AppName")
                        .resizable()
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.height / 5)
                        .padding(.bottom, geometry.size.width * 1.5)
                        .opacity(isOpacity ? 1 : 0)
                        .animation(.easeIn(duration: 5), value: isOpacity)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 2)
                    
                    Image("HomeOnBoard")
                        .resizable()
                        .frame(width: geometry.size.width * 1.05, height: geometry.size.height / 1)
                        .offset(y : geometry.size.width * HomeAnimation)
                        .animation(.easeInOut(duration: 2), value: HomeAnimation)
                    
                    ZStack{
                        ComponentButton(textButton: "Mulai Permainan") {
                            matchManager.initiateMatch()
                        }
                        .offset(y: {
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                return geometry.size.height * 0.05
                            } else {
                                return geometry.size.height * -0.1
                            }
                        }())                        
                        .padding(.trailing, 20)
                        HStack{
                            Image(characters[1].fullImage)
                                .resizable()
                                .scaledToFit()
                            Image(characters[2].fullImage)
                                .resizable()
                                .scaledToFit()
                            Image(characters[4].fullImage)
                                .resizable()
                                .scaledToFit()
                            Image(characters[3].fullImage)
                                .resizable()
                                .scaledToFit()
                            Image(characters[0].fullImage)
                                .resizable()
                                .scaledToFit()
                        }
                        .offset(y: {
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                return geometry.size.height * 0.4
                            } else {
                                return geometry.size.height * 0.1
                            }
                        }())
                        .padding(.trailing, 20)
                    }
                    .opacity(isOpacity ? 1 : 0)
                    .animation(.bouncy(duration: 7), value: isOpacity)
                }
                
            }
           
            .onAppear{
                offsetAnimation = 0.1
                ScaletAnimation = 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    offseYSky = 1.2
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0){
                        HomeAnimation = 0
                        offseYCloud = 0
                        isOpacity = true
                    }
                }
            }
        }
    }
}

#Preview {
    OnBoardView()
        .environmentObject(MatchManager())
}
