//
//  MapAnimation.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 16/11/23.
//

import SwiftUI

struct MapAnimation: View {
    @State private var isAnimating : Bool = false
    @State private var offsety: CGFloat = 0.0
    @State private var offsetx: CGFloat = 0.0
    @State private var scale: CGFloat = 1.0
    @State private var offsetxAwan: CGFloat = 0.5
    @EnvironmentObject var matchManager: MatchManager
    var body: some View {
        Button {
            matchManager.gameStatus = .beginning
        } label: {
            GeometryReader{ geometry in
            ZStack{
                Image("Awan2")
                    .resizable()
                    .frame(width: geometry.size.width * 1)
                Image("Awan")
                    .resizable()
                    .frame(width: geometry.size.width * 1)
                Image("Awan")
                    .resizable()
                    .frame(width: geometry.size.width * 1)
                    .offset(x: offsetxAwan)
                    .scaleEffect(scale)
                    .animation(Animation.linear(duration: 10).repeatForever(), value: isAnimating)
                
                Image("Kapal")
                    .resizable()
                    .frame(width: geometry.size.width * 1)
                    .ignoresSafeArea()
                Image("Air")
                    .resizable()
                    .frame(width: geometry.size.width * 1)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x:offsetx ,y: offsety)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true).delay(1), value: isAnimating)
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
                    .frame(width: geometry.size.width * 1, height: geometry.size.height / 3)
                    .opacity(0.3)
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height / 5.5)
                            .foregroundStyle(.clear)
                            .overlay{
                                Text("Marsiadapari/mar.si.a.da.pa.ri/ a gotong royong yang dilakukan beberapa orang secara serentak (rimpa atau rumpa), agar pekerjaan yang berat dipikul bersama hingga meringankan beban kumpulan.")
                                    .font(.system(size: 16,weight: .regular, design: .serif))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.trailing)
                            }
                            .padding()
                            .padding(.bottom, -geometry.size.width * 0.1)
                        
                    }
                    //
                    .padding(.bottom, 50)
                    
                    
                }
                VStack{
                    Image("Toba")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 1, height: geometry.size.height / 5)
                        .padding(.top, 80)
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .onAppear{
                withAnimation {
                    offsetxAwan = 30
                    scale = 1.2
                    offsety = 10
                    offsetx = 10
                    isAnimating = true
                }
            }
        }
        }

    }
}

#Preview {
    MapAnimation()
}
