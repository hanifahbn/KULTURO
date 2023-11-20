//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct InGameView: View {
    @EnvironmentObject var matchManager : MatchManager
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                ScrollView(.vertical) {
                    ForEach(characters.filter { $0.isChosen != nil }) { karakter in
                        Button(action: {
            //                            matchManager.startVoiceChat()
                            matchManager.chooseCharacter(karakter)
                        }) {
                            ZStack {
                                if(!karakter.isNPC){
                                    TextSound(
                                        imageHalfBody: karakter.headImage, namaChar: karakter.name, asalChar: karakter.origin!, gradienKanan: karakter.colorRight!, gradienKiri: karakter.colorLeft!)
                                }
                            }

                        }
                        .disabled(karakter.isChosen!)
                        .opacity(karakter.isChosen! ? 0.5 : 1.0)
                    }
                }
               
                // Other content can go here
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    InGameView()
        .environmentObject(MatchManager())
}

