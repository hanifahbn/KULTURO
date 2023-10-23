//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct InGameView: View {
    var body: some View {
        ZStack{
            HStack(spacing : 0){
                Button {
                    print("Choose 1")
                } label: {
                    Rectangle()
                        .foregroundStyle(Color("Ungu"))
                        .overlay {
                            Image("PersonOne")
                                .resizable()
                                .scaledToFit()
                        }
                }

                Button {
                    print("Choose 2")
                } label: {
                    Rectangle()
                        .foregroundStyle(Color("Kuning"))
                        .overlay {
                            Image("PersonTwo")
                                .resizable()
                                .scaledToFit()
                        }
                }
            }
            VStack(spacing: 500){
                Text("Choose Character")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.top, 50)
                ComponetButton(textButton: "Start") {
                   print("Next View")
                }
            }
           
        }.ignoresSafeArea()
    }
}

#Preview {
    InGameView()
}
