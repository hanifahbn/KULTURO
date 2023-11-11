//
//  CameraService.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 18/10/23.
//

import Foundation
import AVFoundation
import Vision
import UIKit

protocol CameraServiceDelegate: AnyObject {
    func changeButton(isDisabled: Bool)
}

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, ObservableObject {
    
    var session: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    // Detector
    private var videoOutput = AVCaptureVideoDataOutput()
    var requests = [VNRequest]()
    
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    weak var cameraDelegate: CameraServiceDelegate?
    
    var tool: Tool? = nil

    var isDelay: Bool = false

    // for haptic
    var timerCounter = 0.3
    var hapticViewModel = HapticViewModel()

    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping (Error?) -> ()) {
        self.delegate = delegate
        checkPermissions(completion: completion)
        
    }
    
    private func checkPermissions(completion: @escaping (Error?) -> ()){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){ granted in
                guard granted else {return}
                DispatchQueue.main.async {
                    self.setupCamera(completion: completion)
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            
            setupCamera(completion: completion)
        @unknown default:
            break
        }
    }
    
    
    
    private func setupCamera(completion: @escaping (Error?) -> ()){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do{
                let input = try AVCaptureDeviceInput(device: device)
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                
                // Detector
                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
                
                
                sessionQueue.async { [unowned self] in
                    
                    self.setupDetector()
                    self.session?.startRunning()
                    
                }
                
                self.session = session
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    session.addOutput(videoOutput)
                }
            } catch{
                completion(error)
            }
        }
    }
    
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        output.capturePhoto(with: settings, delegate: delegate!)
    }
}
