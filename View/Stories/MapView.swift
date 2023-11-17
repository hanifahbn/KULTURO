//
//  MapView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 16/11/23.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack{
            Color("AbuAbu")
                .ignoresSafeArea()
            ScrollView(.horizontal) {
                HStack(spacing: -10) {
                    ForEach(1..<10) { num in
                        GeometryReader { geometry in
                            Rectangle()
                                .stroke(lineWidth: 1)
                              
                            
                                .overlay(
                                   MapAnimation()
                                    .scaledToFit()
                                   
                                )
                                .rotation3DEffect(.degrees(-geometry.frame(in: .global).minX) / 10, axis: (x: 0, y: 1, z: 0))
                    
                                .cornerRadius(20)
                                .shadow(radius: 10)
                        }
                        .frame(width: 350, height: 750)
                    }
                }
                .padding(20)
                .padding(.top, 40)// Padding added to better visualize the images
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    MapView()
}
