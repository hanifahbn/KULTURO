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
            matchManager.synchronizeGameState("BEGIN GAME TOBA")
        } label: {
            ZStack{
                Image("Awan2")
                Image("Awan")
                Image("Awan")
                    .resizable()
                    .offset(x: offsetxAwan)
                    .scaleEffect(scale)
                    .animation(Animation.linear(duration: 10).repeatForever(), value: isAnimating)
                
                Image("Kapal")
                    .resizable()
                    .ignoresSafeArea()
                Image("Air")
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
                    .frame(width: 400, height: 200)
                    .opacity(0.3)
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 280, height: 150)
                            .foregroundStyle(.clear)
                            .overlay{
                                Text("Marsiadapari/mar.si.a.da.pa.ri/ a gotong royong yang dilakukan beberapa orang secara serentak (rimpa atau rumpa), agar pekerjaan yang berat dipikul bersama hingga meringankan beban kumpulan.")
                                    .font(.system(size: 16,weight: .regular, design: .serif))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.trailing)
                            }
                            .padding(.trailing, 50)
                            .padding(.bottom, 70)
                    }
                    .padding(.bottom, 50)
                
                    
                }
                VStack{
                    Image("Toba")
                        .resizable()
                        .frame(width: 350, height: 200)
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

//struct CustomBoldModifier: ViewModifier {
//    let text: String
//
//    func body(content: Content) -> some View {
//        let attributedString = NSMutableAttributedString(string: content.description as NSString)
//        let range = (attributedString.string as NSString).range(of: text)
//        
//        if range.location != NSNotFound {
//            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
//        }
//
//        return Text(attributedString)
//    }
//}


#Preview {
    MapAnimation()
}
