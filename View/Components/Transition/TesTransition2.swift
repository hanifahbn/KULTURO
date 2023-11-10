//
//  TesTransition2.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 09/11/23.
//

import SwiftUI

struct TesTransition2: View {
    @StateObject var viewModel : TransitionViewModel = TransitionViewModel()
    var body: some View {
        ZStack{
            Image("BackgroundPanglong")
                .resizable()
                .ignoresSafeArea()
            TransitionOpening(viewModel: viewModel)
        }
    }
}

#Preview {
    TesTransition2()
}
