//
//  TextSound.swift
//  MacroApp
//
//  Created by Hanifah BN on 04/11/23.
//

import SwiftUI

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

//#Preview {
//    TextSound()
//}
