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
        
        
        
        GeometryReader{ geometry in
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .zIndex(1)
                    .foregroundStyle(.black)
                    .opacity(0.3)
                    .overlay {
                        Text("Akan Datang")
                            .font(.custom("Chalkboard-Regular", size: geometry.size.width * 0.2))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .shadow(radius: 10)
                    }
                ZStack{
                    Image("Sunrise")
                        .resizable()
                        .frame(width: geometry.size.width * 1)
                        .ignoresSafeArea()
                    Image("AwanBali2")
                        .resizable()
                        .frame(width: geometry.size.width * 1)
                        .scaleEffect(scale)
                        .animation(Animation.linear(duration: 20).repeatForever(), value: isAnimating)
                    Image("Pura")
                        .resizable()
                        .frame(width: geometry.size.width * 1)
                        .ignoresSafeArea()
                    
                    Image("AwanBali1")
                        .resizable()
                        .frame(width: geometry.size.width * 1)
                        .offset(x: offsetxAwan)
                        .animation(Animation.linear(duration: 5).repeatForever(), value: isAnimating)
                    Image("BaliTitle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 1)
                        .offset(y: CGFloat(offsetTitle))
                        .animation(.easeInOut(duration: 1), value: offsetTitle)
                    Image("AirBali")
                        .resizable()
                        .frame(width: geometry.size.width * 1)
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
                        .ignoresSafeArea()
                        .frame(width: geometry.size.width * 1, height: geometry.size.height / 4)
                        .opacity(0.3)
                    }
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height / 4)
                                .foregroundStyle(.clear)
                                .overlay{
                                    Text("Ngayah/ Nga.yah \n merupakan kearifan lokal yang tumbuh dan berkembang di masyarakat Bali di mana suatu kelompok akan bekerja sama dengan tulus untuk mencapai tujuan tertentu.")
                                        .font(.system(size: 16,weight: .regular, design: .serif))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.trailing)
                                }
                                .padding()
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
}

#Preview {
    MapBaliAnimation()
}
