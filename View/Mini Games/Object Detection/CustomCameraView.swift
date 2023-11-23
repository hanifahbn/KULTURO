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

    @State var isToolDetected: Bool = false
    @State var isViewWarning: Bool = false

    @Binding var tool: Tool

    var toolBrain = ToolBrain()

    var timer = Timer()

    func handleCamerAction() {
        if isToolDetected {
            cameraService.capturePhoto()
        } else{
            isViewWarning = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isViewWarning  = false
            }
        }
    }

    var  body: some View {
        ZStack {
            GeometryReader { geo in
                CameraView(isToolDetected: $isToolDetected, tool: $tool, cameraService: cameraService){result in
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



                ZStack {
                    if(isToolDetected){
                        Rectangle().foregroundStyle(.skyBlue)
                    }else{
                        Rectangle().background(.ultraThinMaterial)
                    }
                    RoundedRectangle(cornerRadius: 81)
                        .blendMode(.destinationOut)
                        .frame(width: geo.size.height * 1/2, height: geo.size.height * 1/2)
                        .padding(.bottom, 116)

                }
                .compositingGroup()
                .ignoresSafeArea()


                VStack{

                    Text(isToolDetected ? "Ketemu" : "Mencari Barang")
                        .font(.custom("Chalkboard-Bold", size: 20))
                        .padding(12)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 8.0
                            )
                            .fill(isToolDetected ? .skyBlue : .black )
                            .opacity(isToolDetected ? 1 : 0.5)
                            .frame(height: 28)
                        )
                        .foregroundStyle(isToolDetected ? .black : .white)
                        .padding(.top, geo.size.height / 5)

                    Spacer()
                    if(isViewWarning){
                        Text("Sesuaikan angle kamera terhadap objek")
                            .font(.custom("Chalkboard-Bold", size: 20))
                            .multilineTextAlignment(.center)
                            .padding(8)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 8.0
                                )
                                .fill(.black)
                                .opacity(0.5)
                            )
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    VStack{
                        ZStack(alignment: .center) {
                            Image("BubbleChat")
                            HStack{
                                Text("Tolong Carikan ")
                                    .font(.custom("Chalkboard-Bold", size: 24))
                                    .foregroundStyle(.black)

                                Text(tool.imageName)
                                    .font(.custom("Chalkboard-Bold", size: 28))
                                    .foregroundStyle(.darkRed)
                            }.padding(.bottom, 32)
                        } .padding(.bottom, -48)

                        HStack{

                            Spacer()

                            Image("Headman")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 88, height: 88)
                                .clipShape(Circle())

                            Spacer()

                            Button(action: handleCamerAction, label: {
                                Image("Camera")
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 22)
                                    .background(isToolDetected ? .gkananKuning : .abuAbu)
                                    .clipShape(Circle())
                            })

                            Spacer()

                            Button(action: {tool = toolBrain.getRandomTool(tool)}, label: {
                                ZStack{
                                    Circle()
                                        .overlay(content: {
                                            Image(tool.imageName)
                                                .resizable()
                                                .padding(12)
                                        })
                                        .foregroundStyle(.ungu)
                                        .frame(width: 76, height: 76)



                                    Circle()
                                        .overlay(content: {
                                            Image(systemName: "arrow.clockwise")
                                                .font(.system(size: 21))
                                                .foregroundStyle(.gkananKuning)

                                        })
                                        .foregroundStyle(.blueTurtle)
                                        .frame(width: 40, height: 40)
                                        .padding(.top, 60)
                                        .padding(.leading, 72)

                                }
                            })

                            Spacer()

                        }
                        .padding(.top, 22)
                        .padding(.bottom, 48)
                    }
                }
            }
        }
    }

}

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
