//
//  ComponentButtonMic.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct ComponetButtonMic: View {
    @State var ButtonTap : Bool = false
    @State var textButton : String
    @State var iconButton : String
    let action: () -> Void
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color("YellowColor"))
                .opacity(0.5)
                .padding(.top, 15)
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color("YellowColor"))
                .padding(.top, ButtonTap ? 15 : 0 )
            HStack{
                Image(systemName: "\(iconButton)")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
                Text(textButton)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(.top, ButtonTap ? 15 : 0 )
        }
        .onTapGesture {
            ButtonTap = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                ButtonTap = false
                action()
            }
        }
        
    }
}

#Preview {
    ComponetButtonMic(textButton: "Lanjutkan", iconButton: "") {
        print("Next")
    }
}
