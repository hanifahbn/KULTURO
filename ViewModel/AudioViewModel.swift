//
//  AudioViewModel.swift
//  MacroTest
//
//  Created by Hanifah BN on 12/10/23.
//

import Foundation
import AVFoundation

//import SoundAnalysis

class AudioViewModel: NSObject, ObservableObject, AVAudioRecorderDelegate {
    @Published var audio = Audio()
    private var audioRecorder: AVAudioRecorder?
    private var audioFilename: URL!
    private var serverViewModel = ServerViewModel()
    var audioPlayer: AVAudioPlayer?
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func startRecording() {
        // Append = buat baru.
        audioFilename = getDocumentsDirectory().appendingPathComponent("recorded.wav")

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 48000.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            // .record = biar app lain gak bisa play audio.
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)

            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            audio.isRecording = true

            print("start recording")
        } catch {
            // Handle
            print("Recording error: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        audio.isRecording = false

        print("stopped recording")
        
        serverViewModel.sendAudioToServer(audioURL: getDocumentsDirectory().appendingPathComponent("recorded.wav"))
        self.audio.label = serverViewModel.responseData
        print("LABEL: \(self.audio.label)")
        
    }

}



