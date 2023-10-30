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

        self.debouncingTimer?.invalidate()
        self.debouncingTimer = nil

        let recognitions = VNCoreMLRequest(model: visionModel)
        { (finishedReq, err) in

            guard let results  = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }

            print("self.tool?.objectIdentifier", self.tool.objectIdentifier)

            if firstObservation.identifier == self.tool.objectIdentifier {


                // change to brown
                //                    DispatchQueue.main.async { [weak self] in
                //                        let camPreviewBounds = self!.view.bounds
                //                        let cropRect = CGRect(
                //                            x: camPreviewBounds.minX + (camPreviewBounds.width - 150) * 0.5,
                //                            y: camPreviewBounds.minY + (camPreviewBounds.height - 150) * 0.5,
                //                            width: 150,
                //                            height: 150
                //                        )
                //
                //                        let path = UIBezierPath(roundedRect: camPreviewBounds, cornerRadius: 0)
                //                        path.append(UIBezierPath(roundedRect: CGRect(x: 50, y: 200, width: 300, height: 500), cornerRadius: 20))
                //
                //                        let layer = CAShapeLayer()
                //                        layer.path = path.cgPath
                //                        layer.fillRule = CAShapeLayerFillRule.evenOdd;
                //                        layer.fillColor = UIColor.brown.cgColor
                //
                //                        self!.view.layer.addSublayer(layer)
                //                    }

                self.cameraDelegate?.changeButton(isDisabled: false)

            } else {

                self.debouncingTimer?.invalidate()
                self.debouncingTimer = nil




                if self.debouncingTimer == nil || self.debouncingTimer?.isValid == false {
                    self.debouncingTimer = Timer.scheduledTimer(
                        withTimeInterval: self.DEBOUNCE_TIME,
                        repeats: false) { [weak self] timer in
                            print("invalidate")
                            timer.invalidate()
                            self?.debouncingTimer = nil
                        }

                    // your heavy functionality
//                    print("hubla")
                    self.cameraDelegate?.changeButton(isDisabled: true)
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
