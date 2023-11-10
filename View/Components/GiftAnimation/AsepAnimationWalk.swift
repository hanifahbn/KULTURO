////
////  AsepAnimationWalk.swift
////  MacroApp
////
////  Created by Irvan P. Saragi on 07/11/23.
////
//
//import SwiftUI
//
//struct AsepAnimationWalk: View {
//    @State var isAnimation : Bool = false
//    @State var isAnimation2 : Bool = false
//    var body: some View {
//        ZStack{
//            Image("BackgroundPanglong")
//                .resizable()
//                .ignoresSafeArea()
//            Button("next"){
//                isAnimation = false
//            }
//            ZStack{
//                GifImage("AnimationAsep")
//                    .frame(width: 200, height: 200)
//                    .offset(x: isAnimation ? 0 : -250)
//                    .animation(.linear(duration: 2), value: isAnimation)
//                    .scaleEffect(x: isAnimation ? 1 : 1)
//                    .opacity(isAnimation2 ? 0 : 1)
////                    .scaleEffect(x: 1, y: 1)
//                Image("FullAsep")
//                    .resizable()
//                    .frame(width: 100, height: 200)
//                    .opacity(isAnimation2 ? 1 : 0)
//            }
//            .offset(y: 150)
//        }
//        .onAppear{
//            isAnimation = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                isAnimation2 = true
//            }
//        }
//    }
//}
//
//#Preview {
//    AsepAnimationWalk()
//}
