//
//  ErrorHandling.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/11/23.
//

import SwiftUI

struct ErrorHandling: View {
    var body: some View {
        ZStack{
            Image("BalaiDesaRenovated")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.8)
            VStack{
                Spacer()
                ZStack{
                    Image("BoxError")
                    Image("jaringanPutus")
                        .padding(.leading, 40)
                }
                .frame(width: 100, height: 100)
                .offset(x: 100, y: 50)
                Image("HalfKepalaDesa")
                    .padding(.bottom, -300)
                Image("TextBoxStory")
                    .resizable()
                    .frame(width: 360, height: 200)
                    .overlay {
                        VStack{
                            HStack{
                                Text("Sepertinya jaringan kamu terganggu")
                                    .font(.custom("Chalkboard-Regular", size: 30))
                                    .foregroundStyle(.black)
                                    .padding(15)
                                Spacer()
                            }
                            .padding()
                            HStack{
                                Spacer()
                                Button(action: {
                                    print("Sound")
                                }, label: {
                                    Image("IconButtonSpeaker")
                                        .resizable()
                                        .frame(width: 70, height: 50)
                                })
                                .padding(.trailing, 15)
                                
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ErrorHandling()
}
