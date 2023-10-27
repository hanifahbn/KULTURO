//
//  CustomCameraView.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 18/10/23.
//

import SwiftUI



struct CustomCameraView: View {

    @StateObject var cameraService = CameraViewController()
    @Binding var capturedImage: UIImage?

    @Environment(\.presentationMode) private var presentationMode

    @State var isDisabled: Bool = true

    @Binding var tool: Tool

    var toolBrain = ToolBrain()

    

    var  body: some View {
        ZStack {
            CameraView(isDisabled: $isDisabled, tool: $tool, cameraService: cameraService){result in
                switch result{
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                        presentationMode.wrappedValue.dismiss()
                    } else{
                        print("Error: No image found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            VStack{
                if(!isDisabled){
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 208, height: 32)
                        .background(.white.opacity(0.6))
                        .cornerRadius(8)
                        .overlay(
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.15, green: 0.31, blue: 0.24).opacity(0.5), lineWidth: 1)
                                HStack{
                                    Text("Tekan tombol shutter.")
                                        .font(
                                            Font.custom("SF Pro Rounded", size: 20)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)


                                }
                            }
                        ).padding([.top], 68)
                }

                Spacer()

                HStack{
                    Button(action: {cameraService.capturePhoto()}, label: {
                        Image(systemName: "camera")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                    }).disabled(isDisabled)
                }
                .frame(height: 75)

                ZStack {
                    HStack(spacing: -60) {
                        Image("Headman")
                            .resizable()
                            .frame(width: 85, height: 87 )
                            .zIndex(1)
                            .padding(.top, -10)


                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 260, height: 76)
                            .background(.white.opacity(0.6))
                            .cornerRadius(16)
                            .overlay(
                                ZStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.15, green: 0.31, blue: 0.24).opacity(0.5), lineWidth: 1)
                                    HStack{
                                        Text("Tolong Carikan")
                                            .font(
                                                Font.custom("SF Pro Rounded", size: 20)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.black)

                                        Button(action: {
                                            tool = toolBrain.getRandomTool()
                                        }) {
                                            Image(tool.imageName).resizable().frame(width: 42, height: 42)
                                        }
                                    }
                                    .padding(.leading, 36)
                                }
                            )


                    }

                }
                .frame(width: 260, height: 76)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .padding(.top, 11)
                .padding(.bottom, 20)
            }
        }
    }

}

