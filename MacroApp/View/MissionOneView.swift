//
//  MissionOneView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct MissionOneView: View {
    let listBelanja = ["Batu", "Rokok", "Semen", "BatuBata"]
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 2.0)
            Image("Paper")
                .overlay {
                    VStack{
                        Text("Barang Belanjaan")
                            .font(.system(size: 20, weight: .semibold))
                        List{
                            ForEach(listBelanja, id: \.self){ item in
                                Text("\(item)")
                                    .font(.system(size: 15,weight: .light))
                                  
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .scrollContentBackground(.hidden)
                    }
                    .padding()
                }
            
           
        }
        
    }
}

#Preview {
    MissionOneView()
}
