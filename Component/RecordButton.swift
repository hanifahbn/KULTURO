//
//  RecordButton.swift
//  MacroApp
//
//  Created by Hanifah BN on 30/10/23.
//

import SwiftUI

struct RecordButton: View {
    @State private var ButtonTap: Bool = false
    @State var textButton: String
    @State var iconButton: String?
    @State var isWithIcon: Bool = false
    
    let action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(ButtonTap ? Color.gray : Color("Kuning"))
//                .opacity(0.5)
                .padding(.top, 15)
            HStack{
                if(isWithIcon == true){
                    Image(systemName: "\(iconButton ?? "")")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.white)
                }
                Text(textButton)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(.top, 15)
        }
        .onTapGesture {
            ButtonTap.toggle()
            action()
        }
    }
}

//#Preview {
//    RecordButton()
//}
