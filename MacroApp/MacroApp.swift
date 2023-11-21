//
//  MacroAppApp.swift
//  MacroApp
//
//  Created by Hanifah BN on 17/10/23.
//

import SwiftUI

@main
struct MacroApp: App {
    
    init(){
        UINavigationBar.appearance().backItem?.hidesBackButton = true
    }
    
    @ObservedObject var router = RouterViewModel()
    
    var body: some Scene {
        WindowGroup {
//            NavigationStack(path: $router.navPath) {
                ContentView()
//                    .environmentObject(router)
//            }
//                ObjectDetectionGame()
        }
    }
}
