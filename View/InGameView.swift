////
////  SwiftUIView.swift
////  MacroApp
////
////  Created by Irvan P. Saragi on 19/10/23.
////
//
//import SwiftUI
//
//struct InGameView: View {
//    @EnvironmentObject var matchManager : MatchManager
//    
//    var body: some View {
//        ZStack{
//            Color.ungu
//                .ignoresSafeArea()
//            ScrollView(.vertical) {
//                ForEach(matchManager.data.characters) { karakter in
//                    Button(action: {
//                        matchManager.chooseCharacter(karakter)
//                    }) {
//                        ZStack {
//                            TextSound(
//                                imageHalfBody: karakter.headImage, namaChar: karakter.name, asalChar: karakter.origin, gradienKanan: karakter.colorRight, gradienKiri: karakter.colorLeft)
//                                .opacity(karakter.name == "Ajeng" || karakter.name == "Dayu" ? 0.3 : 1.0)
//                            
//                            if karakter.name == "Ajeng" || karakter.name == "Dayu" {
//                                Image(systemName: "lock.fill")
//                                    .font(.system(size: 40))
//                                    .foregroundColor(Color("Hijau"))
//                                    .opacity(1.0)
//                                    .padding(20)
//                            }
//                        }
//                    }
//                    .disabled(karakter.isChosen || karakter.name == "Ajeng" || karakter.name == "Dayu")
//                    .opacity(karakter.isChosen ? 0.6 : 1.0)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    InGameView()
//        .environmentObject(MatchManager())
//}
//
//struct TextSound: View {
//    @State var imageHalfBody : String
//    @State var namaChar : String
//    @State var asalChar : String
//    @State var gradienKanan : String
//    @State var gradienKiri : String
//    var body: some View {
//        Rectangle()
//            .frame(width: 348, height: 176)
//            .foregroundStyle(.clear)
//            .background(
//                LinearGradient(
//                    stops: [
//                        Gradient.Stop(color: Color(gradienKiri), location: 0.5),
//                        Gradient.Stop(color: Color(gradienKanan), location: 1.0),
//                    ],
//                    startPoint: .leading,
//                    endPoint: .trailing
//                )
//            )
//            .cornerRadius(24)
//            .overlay {
//                
//                HStack{
//                    Image(imageHalfBody)
//                        .resizable()
//                        .frame(width: 174, height: 174)
//                        .padding(.top,2)
//                    VStack(alignment: .leading){
//                        Text(namaChar)
//                            .font(.system(size: 40, weight: .bold))
//                        Text(asalChar)
//                            .font(.system(size: 30, weight: .light))
//                    }
//                    .foregroundStyle(.black)
//                    .padding(.leading, -20)
//                    
//                    Spacer()
//                }
//            }
//    }
//}

//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/10/23.
//

import SwiftUI

struct InGameView: View {
    @EnvironmentObject var matchManager : MatchManager
    
    var body: some View {
        NavigationStack (){
            ZStack{
                Color(red: 0.97, green: 0.96, blue: 0.96)
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    ForEach(characters.filter { $0.isChosen != nil }) { karakter in
                        Button(action: {
                            matchManager.chooseCharacter(karakter)
                        }) {
                            ZStack {
                                if(!karakter.isNPC){
                                    TextSound(
                                        imageHalfBody: karakter.headImage, namaChar: karakter.name, asalChar: karakter.origin!, gradienKanan: karakter.colorRight!, gradienKiri: karakter.colorLeft!)
                                        .opacity(karakter.name == "Ajeng" || karakter.name == "Dayu" ? 0.3 : 1.0)
        
//                                    if karakter.name == "Ajeng" || karakter.name == "Dayu" {
//                                        Image(systemName: "lock.fill")
//                                            .font(.system(size: 40))
//                                            .foregroundColor(Color("Hijau"))
//                                            .opacity(1.0)
//                                            .padding(20)
//                                    }
                                }
                            }
                        }
                        .disabled(karakter.isChosen!)
                        .opacity(karakter.isChosen! ? 0.6 : 1.0)
                    }
                }
            }
            .environmentObject(MatchManager())
        }
    }
}

#Preview {
    InGameView()
        .environmentObject(MatchManager())
}

