//
//  Transition1.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 06/11/23.
//

import SwiftUI

struct TransitionClosing: View {
    
    
    @StateObject var viewModel = TransitionViewModel()
    var body: some View {
        ZStack {
            
            Image("Transition")
                .resizable()
                .ignoresSafeArea()
                .scaleEffect(CGSize(width: viewModel.transition ? 1 : 300, height: viewModel.transition ? 1 : 300))
                .animation(.easeInOut(duration: 1), value: viewModel.transition)
            
            Image("Transition2")
                .resizable()
                .ignoresSafeArea()
                .opacity(viewModel.transition2 ? 1 : 0)
                .animation(.easeOut, value: viewModel.transition)
        }
    }
}

#Preview {
    TransitionClosing()
}

struct TransitionOpening: View {
    
    
    @StateObject var viewModel = TransitionViewModel()
    var body: some View {
        ZStack {
            Image("Transition")
                .resizable()
                .ignoresSafeArea()
                .scaleEffect(CGSize(width: viewModel.transition ? 300 : 1, height: viewModel.transition ? 300 : 1))
                .animation(.easeInOut(duration: 1.5), value: viewModel.transition)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                viewModel.transition = true
            }
        }
    }
}
