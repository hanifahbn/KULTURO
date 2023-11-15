//
//  SwiftUIView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 15/11/23.
//

import SwiftUI

struct MapView: View {
    @StateObject var router = RouterViewStack()
    var body: some View {
        NavigationStack(path : $router.path){
            VStack{
                Text("Ceritanya Ini Map Danau Toba")
                Button {
                    router.path.append(.beginning)
                } label: {
                    Text("Katanya ini di tap")
                }
            }
            .navigationDestination(for: GameStatus.self) {
                destination in
                ViewFactory.viewForDestination(destination)
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    MapView()
}
