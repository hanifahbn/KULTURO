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
        NavigationStack (){
            ZStack{
                Color(red: 0.97, green: 0.96, blue: 0.96)
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    ForEach(characters.filter { $0.isChosen != nil }) { karakter in
                        Button(action: {
                            matchManager.chooseCharacter(karakter)
                        }) {
                            ZStack {
                                if(!karakter.isNPC){
                                    TextSound(
                                        imageHalfBody: karakter.headImage, namaChar: karakter.name, asalChar: karakter.origin!, gradienKanan: karakter.colorRight!, gradienKiri: karakter.colorLeft!)
                                        .opacity(karakter.name == "Ajeng" || karakter.name == "Dayu" ? 0.3 : 1.0)
        
                                    if karakter.name == "Ajeng" || karakter.name == "Dayu" {
                                        Image(systemName: "lock.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(Color("Hijau"))
                                            .opacity(1.0)
                                            .padding(20)
                                    }
                                }
                            }
                        }
                        .disabled(karakter.isChosen!)
                        .opacity(karakter.isChosen! ? 0.6 : 1.0)
                    }
                }
            }
            .environmentObject(MatchManager())
        }
    }
}

#Preview {
    InGameView()
        .environmentObject(MatchManager())
}

