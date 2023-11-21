//
//  CameraView.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 18/10/23.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    let isToolDetected: Binding<Bool>

    var tool: Binding<Tool>


    let cameraService: CameraViewController
    let didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()

    func makeUIViewController(context: Context) -> UIViewController {

        cameraService.start(delegate: context.coordinator){ err in
            if let err = err {
                didFinishProcessingPhoto(.failure(err))
                return
            }
        }


        let viewController = CameraViewController()
        viewController.view.backgroundColor = .black
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        cameraService.previewLayer.frame = viewController.view.bounds
        cameraService.cameraDelegate = context.coordinator



        return viewController
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self, didFinishProcessingPhoto: didFinishProcessingPhoto, isToolDetectedBinding: isToolDetected)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context)  {
        cameraService.tool = tool.wrappedValue
    }

    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate, CameraServiceDelegate {

        var isToolDetectedBinding: Binding<Bool>

        let parent: CameraView
        private var didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()

        init(_ parent: CameraView, didFinishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> (), isToolDetectedBinding: Binding<Bool>) {
            self.parent = parent
            self.didFinishProcessingPhoto = didFinishProcessingPhoto
            self.isToolDetectedBinding = isToolDetectedBinding
        }

        func changeButton(isToolDetected: Bool) {
            isToolDetectedBinding.wrappedValue = isToolDetected
        }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                didFinishProcessingPhoto(.failure(error))
                return
            }

            didFinishProcessingPhoto(.success(photo))
        }
    }
}
