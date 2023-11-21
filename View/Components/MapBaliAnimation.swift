//
//  MapBaliAnimation.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/11/23.
//

import SwiftUI

struct MapBaliAnimation: View {
    @State private var offsetTitle = -150
    @State private var offsetxAwan: CGFloat = 0
    @State private var isAnimating : Bool = false
    @State private var scale: CGFloat = 1.0
    var body: some View {
        Button {
            print("Story Bali")
        } label: {
            ZStack{
                Image("Sunrise")
                    .resizable()
                    .ignoresSafeArea()
                Image("Pura")
                    .resizable()
                    .ignoresSafeArea()
                
                Image("AwanBali1")
                    .resizable()
                    .offset(x: offsetxAwan)
                    .animation(Animation.linear(duration: 5).repeatForever(), value: isAnimating)
              
                Image("AwanBali2")
                    .resizable()
                    .scaleEffect(scale)
                    .animation(Animation.linear(duration: 20).repeatForever(), value: isAnimating)
                Image("BaliTitle")
                    .resizable()
                    .offset(y: CGFloat(offsetTitle))
                    .animation(.easeInOut(duration: 1), value: offsetTitle)
                Image("AirBali")
                    .resizable()
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut(duration: 2).repeatForever(), value: isAnimating)
                VStack{
                    Spacer()
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white.opacity(0.2), location: 0.00),
                            Gradient.Stop(color: .black, location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                    .frame(width: 400, height: 200)
                    .opacity(0.3)
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 300, height: 150)
                            .foregroundStyle(.clear)
                            .overlay{
                                Text("Ngayah/ Nga.yah \n merupakan kearifan lokal yang tumbuh dan berkembang di masyarakat Bali di mana suatu kelompok akan bekerja sama dengan tulus untuk mencapai tujuan tertentu.")
                                    .font(.system(size: 16,weight: .regular, design: .serif))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.trailing)
                            }
                            .padding(.trailing, 50)
                            .padding(.bottom, 10)
                        
                    }
                    //
                    .padding(.bottom, 50)
                }
            }
            .onAppear{
                withAnimation {
                    offsetTitle = 40
                    scale = 1.2
                    offsetxAwan = 30
                    isAnimating = true
                }
            }
        }

    }
}

#Preview {
    MapBaliAnimation()
}
