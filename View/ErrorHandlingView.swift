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
        ZStack{
            Image("BalaiDesaRenovated")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.7)
            VStack{
                Spacer()
                ZStack{
                    Image("BoxError")
                    Image(matchManager.errorType == .noConnection ? "jaringanPutus" : "SinyalTemanHilang")
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
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        }
                    }
            }
        }
    }
}

#Preview {
    ErrorHandlingView()
        .environmentObject(MatchManager())
}
