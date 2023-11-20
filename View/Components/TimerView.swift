//
//  TimerView.swift
//  MacroApp
//
//  Created by Hanifah BN on 16/11/23.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var matchManager: MatchManager
    @State var counter: Int = 0
    var countTo: Int = 10
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundColor(.kuning)
                    .frame(width: 90, height: 90)
                ProgressBar(counter: counter, countTo: countTo)
                Text(matchManager.timeInString)
                    .font(.custom("Chalkboard-Regular", size: 20))
                    .foregroundStyle(counter == countTo ? .darkRed : .blueTurtle)
                    .fontWeight(.bold)
            }
        }
        .onChange(of: matchManager.timeInString) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
            }
        }
//        .onAppear{
//            matchManager.startTimer(time: 5)
//        }
    }
}

#Preview {
    TimerView()
        .environmentObject(MatchManager())
}
