//
//  BalaiDesaRenovatedView.swift
//  MacroApp
//
//  Created by Hanifah BN on 08/11/23.
//

import SwiftUI

struct BalaiDesaRenovatedView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @State var isGoingToNextView : Bool = false
    @State var isTapGestureEnabled = true
    @State var currentIndex = 0

    var body: some View {
        ZStack{
            // MARK: INI NANTI DIBUAT ANIMASI CHARACTER JALAN
            Rectangle()
                .ignoresSafeArea()
                .zIndex(1)
                .opacity(isGoingToNextView ? 1 : 0)
                .animation(.easeIn(duration: 1), value: isGoingToNextView)
            Image("BalaiDesaRenovated")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Image(medanSuccessStories[currentIndex].isTalking.halfImage)
                }
                .padding(.bottom, -300)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 0, y: 5)
                    .overlay {
                        VStack{
                            HStack{
                                Text(medanSuccessStories[currentIndex].text)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding(15)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 350, height: 200)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            if isTapGestureEnabled {
                if currentIndex < medanSuccessStories.count - 1 {
                    currentIndex += 1
                }
                else {
                    isTapGestureEnabled = false
                }
            }
        }

    }
}

#Preview {
    BalaiDesaRenovatedView()
        .environmentObject(MatchManager())
}
