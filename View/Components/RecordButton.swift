//
//  RecordButton.swift
//  MacroApp
//
//  Created by Hanifah BN on 30/10/23.
//

import SwiftUI

struct RecordButton: View {
    @State private var ButtonTap : Bool = false
    @Binding var textButton : String
    @Binding var isWithIcon : Bool
    @Binding var buttonColor : String
    @Binding var textColor : String
    
    let action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color(buttonColor))
                .opacity(0.3)
                .padding(.top, 15)
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 342, height: 50)
                .foregroundStyle(Color(buttonColor))
                .padding(.top, ButtonTap ? 15 : 0 )
            HStack{
                if(isWithIcon == true){
                    Image(systemName: "mic.fill")
                    Text(textButton)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(textColor))
                } else {
                    SoundWaveView(waveColor: .blueTurtle,
                              numberOfWaves: 5,
                              waveWidth: 10,
                              waveSpacing: 8)
                    .padding()
                }
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
