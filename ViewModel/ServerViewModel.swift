//
//  ServerViewModel.swift
//  MacroTest
//
//  Created by Hanifah BN on 23/10/23.
//

import Foundation
import Combine

class ServerViewModel: ObservableObject {
    @Published var responseData: String = "" {
        didSet {
            responseDataDidChange?(responseData)
        }
    }

    var responseDataDidChange: ((String) -> Void)?
    
    func sendAudioToServer(audioURL: URL) {
        if let serverURL = URL(string: "https://headturner.et.r.appspot.com/") {
            var request = URLRequest(url: serverURL)
            request.httpMethod = "POST"

            // Set the appropriate content type, e.g., "audio/wav"
            request.setValue("audio/wav", forHTTPHeaderField: "Content-Type")

            do {
                // Read the audio file data
                let audioData = try Data(contentsOf: audioURL)

                let boundary = "Boundary-\(UUID().uuidString)"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                var body = Data()
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"file\"; filename=\"audio.wav\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
                body.append(audioData)
                body.append("\r\n".data(using: .utf8)!)
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)

                request.httpBody = body

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error sending audio to server: \(error.localizedDescription)")
                    } else if let data = data {
                        if let responseString = String(data: data, encoding: .utf8) {
                            DispatchQueue.main.async {
                                self.responseData = responseString
                                print("RESPONSE DATA: \(self.responseData)")
                            }
                        }
                    }
                }.resume()
            } catch {
                print("Error reading audio data: \(error.localizedDescription)")
            }
        }
    }
}

struct Response: Codable {
    let message: String
}
