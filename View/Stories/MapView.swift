//
//  MapView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 16/11/23.
//

import SwiftUI

struct MapView: View {
    @State var map: [AnyView] = [AnyView(MapAnimation()), AnyView(MapBaliAnimation())]
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Color("AbuAbu")
                    .ignoresSafeArea()
                VStack{
                    Text("Pilih Cerita")
                        .font(.custom("Chalkboard-Regular", size: 35))
                        .foregroundStyle(.black)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    
                    HStack(spacing: -10) {
                        ForEach(map.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                
                                Rectangle()
                                    .stroke(lineWidth: 0)
                                    .overlay(
                                        map[index]
                                    )
                                    .rotation3DEffect(.degrees(-geometry.frame(in: .global).minX) / 10, axis: (x: 0, y: 1, z: 0))
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                            }
                            .frame(width: geometry.size.width * 0.87, height: geometry.size.height / 1.08)
                        }
                    }
                    .padding(24)
                    .padding(.top, geometry.size.width * 0.015)
                }.padding(.top, geometry.size.width * 0.03)
            }
        }
    }
}


#Preview {
    MapView()
}
