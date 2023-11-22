//
//  SoundWave.swift
//  MacroApp
//
//  Created by Hanifah BN on 22/11/23.
//

import SwiftUI

class WaveViewModel: ObservableObject {
    @Published var waveAmplitudes: [CGFloat]

    init(numberOfWaves: Int) {
        self.waveAmplitudes = Array(repeating: 30, count: numberOfWaves)
        animateWaves()
    }

    func animateWaves() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async {
                self.waveAmplitudes = (0..<self.waveAmplitudes.count).map { _ in
                    CGFloat.random(in: 10...20)
                }
            }
        }
    }
}

struct SoundWaveView: View {
    @ObservedObject var viewModel: WaveViewModel
    let waveColor: Color
    let waveWidth: CGFloat
    let waveSpacing: CGFloat

    init(waveColor: Color, numberOfWaves: Int, waveWidth: CGFloat, waveSpacing: CGFloat) {
        self.waveColor = waveColor
        self.waveWidth = waveWidth
        self.waveSpacing = waveSpacing
        self.viewModel = WaveViewModel(numberOfWaves: numberOfWaves)
    }

    var body: some View {
        HStack(spacing: waveSpacing) {
            ForEach(0..<viewModel.waveAmplitudes.count, id: \.self) { waveIndex in
                RoundedRectangle(cornerRadius: waveWidth / 2)
                    .fill(waveColor)
                    .frame(width: waveWidth,
                           height: viewModel.waveAmplitudes[waveIndex])
            }
        }
    }
}

#Preview {
    SoundWaveView(waveColor: .blueTurtle,
              numberOfWaves: 5,
              waveWidth: 6,
              waveSpacing: 8)
    .padding()
}
