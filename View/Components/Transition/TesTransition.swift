//
//  TesTransition.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 09/11/23.
//

import SwiftUI

struct TesTransition: View {
    @StateObject var viewModel : TransitionViewModel = TransitionViewModel()
    var body: some View {
        if viewModel.navigateToNextView{
            TesTransition2()
        } else {
            ZStack{
                Image("BackgroundGudang")
                    .resizable()
                    .ignoresSafeArea()
                TransitionClosing(viewModel: viewModel)
                Button("Next"){
                    viewModel.startTransition()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        viewModel.navigateToNextView = true
                    }
                }
            }
        }
    }
}

#Preview {
    TesTransition()
}
