//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct InGameView: View {
    @StateObject var router = Router()
    var body: some View {
        var gradient = LinearGradient(
            gradient: Gradient(colors: [Color.red, Color.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        NavigationStack (path: $router.path){
            ZStack{
                Color(red: 0.97, green: 0.96, blue: 0.96)
                    .ignoresSafeArea()
                ScrollView (.vertical){
                    ZStack{
                        Button(action: {
                            router.path.append(.narator)
                        }, label: {
                            TextSound(imageHalfBody: "Dayu", namaChar: "Dayu", asalChar: "Bali", gradienKanan: "GkananKuning", gradienKiri: "GkiriKuning")
                        })
                        Button(action: {
                            
                        }, label: {
                            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        })
                    }
                    Button(action: {
                        router.path.append(.narator)
                    }, label: {
                        TextSound(imageHalfBody: "Eyog", namaChar: "Togar", asalChar: "Batak", gradienKanan: "GkananHijau", gradienKiri: "GkiriHijau")
                    })
                    Button(action: {
                        router.path.append(.narator)
                    }, label: {
                        TextSound(imageHalfBody: "Gale", namaChar: "Oman", asalChar: "Bandung",  gradienKanan: "GkananBiru", gradienKiri: "GkiriBiru")
                    })
                    Button(action: {
                        router.path.append(.narator)
                    }, label: {
                        TextSound(imageHalfBody: "Ajeng", namaChar: "Ajeng", asalChar: "Solo",  gradienKanan: "GkananUngu", gradienKiri: "GkiriUngu")
                    })
                }
                .padding()
            }
            .navigationDestination(for: Destination.self) {
                destination in
                ViewFactory.viewForDestination(destination)
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    InGameView()
}

struct TextSound: View {
    @State var imageHalfBody : String
    @State var namaChar : String
    @State var asalChar : String
    @State var gradienKanan : String
    @State var gradienKiri : String
    var body: some View {
        Rectangle()
            .frame(width: 348, height: 176)
            .foregroundStyle(.clear)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(gradienKiri), location: 0.5),
                        Gradient.Stop(color: Color(gradienKanan), location: 1.0),
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(24)
            .overlay {
                
                HStack{
                    Image(imageHalfBody)
                        .resizable()
                        .frame(width: 174, height: 174)
                        .padding(.top,2)
                    VStack(alignment: .leading){
                        Text(namaChar)
                            .font(.system(size: 40, weight: .bold))
                        Text(asalChar)
                            .font(.system(size: 30, weight: .light))
                    }
                    .foregroundStyle(.black)
                    .padding(.leading, -20)
                    Spacer()
                    
                }
            }
    }
}
