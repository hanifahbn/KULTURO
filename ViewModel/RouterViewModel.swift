//
//  RouterViewModel.swift
//  MacroApp
//
//  Created by Hanifah BN on 12/11/23.
//

import Foundation
import SwiftUI

class RouterViewModel: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: GameStatus) {
        navPath.append(destination)
    }
    
    func clear() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
