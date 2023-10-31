//
//  PlayerViewModel.swift
//  MacroTest
//
//  Created by Hanifah BN on 17/10/23.
//

import Foundation
import AVFoundation
import Combine

class PlayerViewModel: ObservableObject {
    var player: AVAudioPlayer?
    private var cancellable: AnyCancellable?

    func playAudio(fileName: String) {
        do {
            // Set the audio session category to Playback
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }

        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
            print("Audio file not found.")
                return
        }

        do {
            // Create the AVAudioPlayer instance with the audio file URL
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func playAudioLoop(fileName: String, isLooping: Bool = true) {
        do {
            // Set the audio session category to Playback
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }

        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
            print("Audio file not found.")
            return
        }

        do {
            // Create the AVAudioPlayer instance with the audio file URL
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.prepareToPlay()

            if isLooping {
                player?.numberOfLoops = -1 // Set to loop indefinitely
            }

            cancellable = AVAudioSession.sharedInstance().publisher(for: \.secondaryAudioShouldBeSilencedHint)
            .sink { [weak self] shouldBeSilenced in
                if shouldBeSilenced {
                    // Ada gangguan audio (misalnya, mikrofon aktif), hentikan backsound
                    self?.stopAudio()
                } else {
                    // Gangguan audio selesai, lanjutkan backsound
                    self?.player?.play()
                }
            }
            
            player?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func stopAudio() {
        if let player = player, player.isPlaying {
            player.stop()
        }
    }
}

