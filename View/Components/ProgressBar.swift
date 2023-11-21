//
//  ProgressBar.swift
//  MacroApp
//
//  Created by Hanifah BN on 16/11/23.
//

import SwiftUI

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 70, height: 70)
                .overlay(
                    Circle().stroke(.kuning, lineWidth: 3)
                )
//                .shadow(color: .darkRed, radius: countTo > 3 ? 10 : 0)
            Circle()
                .fill(Color.clear)
                .frame(width: 70, height: 70)
                .rotationEffect(.degrees(-180))
                .overlay(
                    Circle().trim(from: progress(), to: 1.0)
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 3,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                        .foregroundColor(
                            (countTo == 3 ? .darkRed : .blueTurtle)
                        )
                        .animation(
                            .easeInOut(duration: 0.2), value: counter
                        )
                        .rotationEffect(.degrees(-90))
                )
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

#Preview {
    ProgressBar(counter: 0, countTo: 10)
}

