//
//  Detector.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 18/10/23.
//

import Vision
import AVFoundation
import UIKit

extension CameraViewController {

    func setupDetector() {

        guard let visionModel = try? VNCoreMLModel(for: Resnet50().model) else { return }



        let recognitions = VNCoreMLRequest(model: visionModel)
        { [self] (finishedReq, err) in

            guard let results  = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }

            if firstObservation.identifier == self.tool?.objectIdentifier {

                if (!isDelay) {
                    self.isDelay = true
                    self.cameraDelegate?.changeButton(isDisabled: false)

                    // haptic setiap kelipatan 0.3
                    self.hapticViewModel.simpleSuccess()
                    for _ in 1...9 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + timerCounter) {
                            self.hapticViewModel.simpleSuccess()
                        }
                        self.timerCounter += 0.3
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isDelay = false
                        self.timerCounter = 0.3
                    }
                }

            } else {
                if !isDelay {
                    self.cameraDelegate?.changeButton(isDisabled: true)
                    self.isDelay = false
                }
            }

        }

        self.requests = [recognitions]

    }

    func setupLayers() {
        // setup blur layer
        DispatchQueue.main.async { [weak self] in
            let blur = UIBlurEffect(style: .regular)
            let blurView = UIVisualEffectView(effect: blur)
            blurView.frame = self!.view.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self!.view.addSubview(blurView)

            let path = UIBezierPath(rect: blurView.bounds)
            path.usesEvenOddFillRule = true
            path.append(UIBezierPath(roundedRect: CGRect(x: 50, y: 60, width: 300, height: 592), cornerRadius: 20))

            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.fillRule = .evenOdd
            blurView.layer.mask = layer
        }

    }


    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:]) // Create handler to perform request on the buffer


        do {
            try imageRequestHandler.perform(self.requests) // Schedules vision requests to be performed
        } catch {
            print(error)
        }
    }

}
