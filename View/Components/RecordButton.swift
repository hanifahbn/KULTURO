//
//  RecordButton.swift
//  MacroApp
//
//  Created by Hanifah BN on 30/10/23.
//

import SwiftUI

struct RecordButton: View {
    @State private var ButtonTap : Bool = false
    @State var textButton : String
    @State var iconButton : String = ""
    @State var isWithIcon : Bool = true
    
    let action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color("Kuning"))
                .opacity(0.3)
                .padding(.top, 15)
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(ButtonTap ? Color.gray : Color("Kuning"))
                .padding(.top, ButtonTap ? 15 : 0 )
            HStack{
                if(isWithIcon == true){
                    Image("\(iconButton)")
//                        .font(.system(size: 30, weight: .bold))
//                        .foregroundStyle(.black)
                }
                Text(ButtonTap ? "Tekan Jika Selesai" : "Tekan Untuk Bicara")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
            .padding(.top, ButtonTap ? 15 : 0 )
        }
        .onTapGesture {
            ButtonTap.toggle()
            isWithIcon.toggle()
            action()
        }
        
    }
}

//#Preview {
//    RecordButton()
//}
