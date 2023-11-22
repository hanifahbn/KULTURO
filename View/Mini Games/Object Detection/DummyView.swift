//
//  DummyView.swift
//  MacroApp
//
//  Created by Hanifah BN on 09/11/23.
//

import SwiftUI

struct DummyView: View {
    @EnvironmentObject var matchManager: MatchManager
    @State private var isClicked = false
    
    var body: some View {
        SoundWaveView(waveColor: .blue,
                  numberOfWaves: 5,
                  waveWidth: 10,
                  waveSpacing: 8)
        .padding()
        Button(action: {
//            matchManager.toggleSpeaking()
            if !isClicked {
                matchManager.startVoiceChat()
                matchManager.informVoiceChatActivation("ACTIVATE")
            }
            else{
                matchManager.startVoiceChat()
                matchManager.informVoiceChatActivation("DEACTIVATE")
            }
            isClicked.toggle()
        }) {
            Text(isClicked ? "Listening.." : "Start")
                .padding()
                .foregroundColor(.white)
                .background(isClicked ? Color.blue : Color.green)
                .cornerRadius(8)
                .animation(.easeInOut, value: isClicked) // Add animation for smoother transition
        }
        .onAppear{
            
        }
    }
}


#Preview {
    DummyView()
        .environmentObject(MatchManager())
}
