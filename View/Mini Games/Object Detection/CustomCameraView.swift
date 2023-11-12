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
            }.ignoresSafeArea()
            VStack{

                HStack(){

                    HStack(spacing: -60) {
                        Image("Headman")
                            .resizable()
                            .frame(width: 70, height: 74)
                            .zIndex(1)
                            .padding(.bottom, 15)


                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 177, height: 55)
                            .background(.white.opacity(0.6))
                            .cornerRadius(16)
                            .overlay(
                                ZStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.15, green: 0.31, blue: 0.24).opacity(0.5), lineWidth: 1)
                                    VStack(alignment: .leading){

                                        Text("Tolong Carikan")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)

                                        Text(tool.imageName)
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.darkRed)
                                    }
                                }
                            )
                            .padding(.leading, 36)
                    }

                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 110, height: 55)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .overlay(content: {
                            HStack{
                                Image("IconTimer")
                                    .font(.system(size: 25, weight: .bold))
                                Text(matchManager.timeInString)
                                    .font(.system(size: 17, weight: .bold))
                            }
                        })
                }
                .padding(.trailing, 30)



                Spacer()

                HStack{

                    Circle()
                        .overlay(content: {
                            VStack{
                                Image(tool.imageName)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }
                        })
                        .foregroundColor(.ungu)
                        .frame(width: 76, height: 76)

                    Spacer()

                    Button(action: {cameraService.capturePhoto()}, label: {
                        Image(isDisabled ? "CameraOff" : "Camera")
                            .padding(.horizontal, 18)
                            .padding(.vertical, 22)
                            .background(isDisabled ? .darkRed : .gkananKuning)
                            .clipShape(Circle())
                    })
                    .disabled(isDisabled)

                    Spacer()

                    Button(action: {tool = toolBrain.getRandomTool(tool)}, label: {
                        Image(systemName: "arrow.circlepath")
                            .padding(.horizontal, 18)
                            .padding(.vertical, 22)
                            .background(.blueTurtle)
                            .foregroundColor(.gkananKuning)
                            .clipShape(Circle())
                            .font(.system(size: 28))
                    })
                }
                .padding(.top, 22)
                .padding(.bottom, 48)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.2))

            }
        }
    }

}

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
