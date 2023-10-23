//
//  MissionOneView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct MissionOneView: View {
    let listBelanja = ["Batu Kecil", "Kayu", "Semen", "BatuBata"]
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 2.0)
            VStack{
                Image("Paper")
                    .padding(.leading, 30)
                    .overlay {
                        VStack{
                            Text("Barang Belanjaan")
                                .font(.system(size: 30, weight: .semibold))
                                .font(.title)
                            List{
                                ForEach(listBelanja, id: \.self){ item in
                                    HStack{
                                        Text("\(item)")
                                            .font(.system(size: 20,weight: .light))
                                            .listRowBackground(Color.clear)
                                            .listRowSeparator(.hidden)
                                        Spacer()
                                        Rectangle()
                                            .stroke(lineWidth: 4)
                                            .frame(width: 30)
                                            
                                    }
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                            .scrollContentBackground(.hidden)
                        }
                        .padding()
                    }
                ComponetButtonMic(textButton: "Tekan Untuk Bicara", iconButton: "mic.fill") {
                    print("Open Mic")
                }
            }
            
           
        }
        
    }
}

#Preview {
    MissionOneView()
}
