//
//  ViewModelTransition.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 09/11/23.
//

import Foundation

class TransitionViewModel : ObservableObject{
    
    @Published var transition: Bool = false
    @Published var transition2: Bool = false
    @Published var navigateToNextView: Bool = false
    
    
    
    func startTransition() {
        transition = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.transition2 = true
        }
    }
    
    func stopTransition (){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.transition2 = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.transition = false
            }
        }
    }
}
