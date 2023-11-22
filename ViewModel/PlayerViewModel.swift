//
//  PlayerViewModel.swift
//  MacroTest
//
//  Created by Hanifah BN on 17/10/23.
//

import Foundation
import AVFoundation
import Combine

class PlayerViewModel: NSObject,ObservableObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    private var cancellable: AnyCancellable?

    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    func playAudio(fileName: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
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

    func playAudioStory(fileName: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }

        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "m4a") else {
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

    func playAudioLoop(fileName: String, isLooping: Bool = true, volume: Float = 1.0) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }

        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
            print("Audio file not found.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.prepareToPlay()
            player?.volume = volume

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

    // function that can play multiple sounds in one session
    func playMultipleSound(fileName: String) {

        if duplicatePlayers.count == 1 {
            duplicatePlayers.removeLast()
        }


        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "m4a") else {
            print("Audio file not found.")
            return
        }

        // player is in use, create a new, duplicate, player and use that instead
        do {
            let duplicatePlayer = try AVAudioPlayer(contentsOf: audioURL)

            duplicatePlayer.delegate = self
            //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing

            duplicatePlayers.append(duplicatePlayer)
            //add duplicate to array so it doesn't get removed from memory before finishing

            duplicatePlayer.prepareToPlay()
            duplicatePlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func playBacksoundOnly()  {
        duplicatePlayers = []
    }

    func stopAudio() {
        if let player = player, player.isPlaying {
            player.stop()
        }
    }
}

