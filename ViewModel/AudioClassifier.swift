//
//  AudioClassifier.swift
//  MacroTest
//
//  Created by Hanifah BN on 13/10/23.
//

import Foundation
import AVFoundation
import SoundAnalysis

class AudioClassifier: NSObject, SNResultsObserving {

    private let model: MLModel
    private var request: SNClassifySoundRequest
    private var results: [(String, Double)] = []
    var result : String
    var resultUpdatedClosure: ((String) -> Void)?
    private var completion: (String?) -> () = { _ in }
//    private var mostConfidentResult: (String, Double)?

    init?(model: MLModel) {

        guard let request = try? SNClassifySoundRequest(mlModel: model) else {
            return nil
        }

        self.model = model
        self.request = request
        self.result = "None"

    }
    
//    func request(_ request: SNRequest, didProduce result: SNResult) {
//        guard let results = result as? SNClassificationResult, let result = results.classifications.first else {
//            return
//        }
//
//        if result.confidence > 0.8 {
//            // Update the most confident result during each classification.
//            if mostConfidentResult == nil || result.confidence > mostConfidentResult!.1 {
//                mostConfidentResult = (result.identifier, result.confidence)
//            }
//        }
//    }


    func request(_ request: SNRequest, didProduce result: SNResult) {

        guard let results = result as? SNClassificationResult,
          let result = results.classifications.first else { return }

        if result.confidence > 0.8 {
            print(result.identifier)
            print(result.confidence)
            self.results.append((result.identifier, result.confidence))
        }

    }

//    func requestDidComplete(_ request: SNRequest) {
//            if let result = mostConfidentResult {
//                completion(result.0)
//            } else {
//                completion(nil)
//            }
//        }

    func requestDidComplete(_ request: SNRequest) {

        self.results.sort {
            return $0.1 > $1.1
        }
        
        guard let result = self.results.first else { return }
//        self.result = self.results.first?.0 ?? "None"
        
        print(result)
        self.completion(result.0)
//        print(self.completion)

    }

    
//    func classify(audioFile: URL, completion: @escaping (String?) -> Void) {
//        completion(nil) // Reset any previous results.
//        mostConfidentResult = nil // Reset the mostConfidentResult.
//        self.completion = completion
//
//        guard let request = try? SNClassifySoundRequest(mlModel: model) else {
//            completion(nil)
//            return
//        }
//
//        self.request = request
//
//        guard let analyzer = try? SNAudioFileAnalyzer(url: audioFile) else {
//            completion(nil)
//            return
//        }
//
//        do {
//            try analyzer.add(self.request, withObserver: self)
//            analyzer.analyze()
//        } catch {
//            completion(nil)
//        }
//    }
    
    func classify(audioFile: URL, completion: @escaping (String?) -> Void) {

        self.completion = completion

        guard let analyzer = try? SNAudioFileAnalyzer(url: audioFile),
              let _ = try? analyzer.add(self.request, withObserver: self) else {
            return
        }

        analyzer.analyze()
        
    }
}
