//
//  CustomCameraView.swift
//  camera
//
//  Created by Auliya Michelle Adhana on 18/10/23.
//

import SwiftUI



struct CustomCameraView: View {
    @EnvironmentObject var matchManager: MatchManager

    @StateObject var cameraService = CameraViewController()
    @Binding var capturedImage: UIImage?

    @Environment(\.presentationMode) private var presentationMode

    @State var isDisabled: Bool = true

    @Binding var tool: Tool

    var toolBrain = ToolBrain()

    var timer = Timer()



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

                HStack(){

                    HStack(spacing: -60) {
                        Image("Headman")
                            .resizable()
                            .frame(width: 75, height: 79 )
                            .zIndex(1)
                            .padding(.bottom, 28)


                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 217, height: 48)
                            .background(.white.opacity(0.6))
                            .cornerRadius(16)
                            .overlay(
                                ZStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.15, green: 0.31, blue: 0.24).opacity(0.5), lineWidth: 1)
                                    HStack{
                                        Button(action: {
                                            tool = toolBrain.getRandomTool(tool)
                                        }) {
                                            Text("Tolong Carikan")
                                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                                .foregroundColor(.black)
                                        }


                                        Button(action: {
                                            tool = toolBrain.getRandomTool(tool)
                                        }) {
                                            Image(tool.imageName).resizable().frame(width: 42, height: 42)
                                        }

                                        Button(action: {
                                            tool = toolBrain.getRandomTool(tool)
                                        }, label: {
                                            Image(systemName: "arrow.triangle.2.circlepath")
                                                .padding(8)
                                                .background(.black)
                                                .foregroundColor(.white)
                                                .clipShape(Circle())

                                        })
                                    }
                                    .padding(.leading, 48)
                                }
                            )
                    }

                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 120, height: 54)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .overlay(content: {
                            HStack{
                                Image(systemName: "timer")
                                    .font(.system(size: 32, weight: .bold))
//                                Text(matchManager.timeInString)
//                                    .font(.system(size: 19, weight: .bold))
                            }
                        })
                }
                .padding(.trailing, 30)
                .padding(.top, 60)



                Spacer()

                HStack{
                    Button(action: {cameraService.capturePhoto()}, label: {
                        Image(isDisabled ? "CameraOff" : "Camera")
                            .padding(.horizontal, 18)
                            .padding(.vertical, 22)
                            .background(isDisabled ? .abuAbu : .ungu)
                            .clipShape(Circle())
                    })
                    .disabled(isDisabled)
                }
                .padding(.bottom, 60)


            }
        }
    }

}

