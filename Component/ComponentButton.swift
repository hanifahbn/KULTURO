//
//  ButonStartCompponet.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 20/10/23.
//

import SwiftUI

struct ComponentButton: View {
    @State var ButtonTap : Bool = false
    @State var textButton : String
    let action: () -> Void
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color("Hijau"))
                .opacity(0.5)
                .padding(.top, 15)
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color("Hijau"))
                .padding(.top, ButtonTap ? 15 : 0 )
            Text(textButton)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
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
    ComponentButton(textButton: "Text") {
            print("Button Tapped")
        }
}
