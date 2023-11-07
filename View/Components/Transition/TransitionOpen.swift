//
//  Transition1.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 06/11/23.
//

import SwiftUI

struct TransitionOpen: View {
    @State var transition: Bool = false
    @State var transition2: Bool = false

    func startTransition() {
        transition = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            transition2 = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                transition2 = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    transition = false
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
                .blur(radius: 1.5)
                .ignoresSafeArea()
            
            Image("Transition")
                .resizable()
                .ignoresSafeArea()
                .scaleEffect(CGSize(width: transition ? 1 : 300, height: transition ? 1 : 300))
                .animation(.easeInOut(duration: 1.5), value: transition)
            
            Image("Transition2")
                .resizable()
                .ignoresSafeArea()
                .opacity(transition2 ? 1 : 0)
                .animation(.easeOut, value: transition2)
            
            Button("Next") {
                startTransition()
            }
        }
    }
}

#Preview {
    TransitionOpen()
}
