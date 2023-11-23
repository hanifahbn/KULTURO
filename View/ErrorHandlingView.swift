//
//  ErrorHandling.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 19/11/23.
//

import SwiftUI

struct ErrorHandlingView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @State var pesanError: String = "Kosong"
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Image("BalaiDesaRenovated")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.7)
                ZStack{
                    HStack{
                        ZStack{
                            Image("BoxError")
                            Image(matchManager.errorType == .noConnection ? "jaringanPutus" : "SinyalTemanHilang")
                                .padding(.leading, 40)
                        }
                    }
                    .padding(.bottom, geometry.size.width * 1)
                    .padding(.leading, geometry.size.width * 0.6)
                    Image("KepalaDesaFrown")
                        .padding(.top, 100)
                    VStack{
                        Image("TextBoxStory")
                            .resizable()
                            .frame(width: geometry.size.width * 1, height: geometry.size.height / 3)
                            .overlay {
                                VStack{
                                    HStack{
                                        Text(pesanError)
                                            .font(.custom("Chalkboard-Regular", size: 25))
                                            .foregroundStyle(.darkRed)
                                            .padding(15)
                                            .onAppear{
                                                if matchManager.errorType == .noConnection {
                                                    pesanError = "Sayang sekali, koneksi internet kamu terputus."
                                                }
                                                else{
                                                    pesanError = "Temanmu mengalami ketidakstabilan jaringan internet dan terputus dari permainan. Mulailah permainan baru."
                                                }
                                            }
                                    }
                                }
                                .padding()
                                
                            }
                        ComponentButtonMic(textButton: "Keluar") {
                            print("Keluar")
                        }
                    }
                    .padding(.top, geometry.size.height * 0.25)
                    .padding(.trailing, 15)
                }
            }
        }
    }
}

#Preview {
    ErrorHandlingView()
        .environmentObject(MatchManager())
}
