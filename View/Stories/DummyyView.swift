//
//  DummyView.swift
//  MacroApp
//
//  Created by Hanifah BN on 20/11/23.
//

import SwiftUI

struct DummyyView: View {
    @State private var isModalPresented = false

    var body: some View {
        VStack {
            Text("Your main content here")
            Button("Show Modal") {
                isModalPresented.toggle()
            }
        }
        .overlay(
            ModalBView(isPresented: $isModalPresented)
                .opacity(isModalPresented ? 1 : 0)
                .animation(.easeInOut(duration: 0.3))
        )
    }
}

struct ModalBView: View {
    @Binding var isPresented: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("This is a modal view!")
                    .padding()
                Button("Close") {
                    isPresented = false
                }
            }
            .frame(width: geometry.size.width * 0.8, height: 200)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            // Close modal when tapping outside
            isPresented = false
        }
    }
}


#Preview {
    DummyyView()
}
