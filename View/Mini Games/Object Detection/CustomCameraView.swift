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
            GeometryReader { geo in
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



                ZStack {
                    if(isDisabled){
                        Rectangle().background(.ultraThinMaterial)
                    }else{
                        Rectangle().foregroundStyle(Color.skyBlue)
                    }
                    RoundedRectangle(cornerRadius: 81)
                        .frame(width: geo.size.width / 1.3, height: geo.size.height * 0.5)
                        .blendMode(.destinationOut)
//                        .padding(.bottom, 120)
                }

                .compositingGroup()
                .ignoresSafeArea()


                VStack{

                    HStack(){
                        Spacer()
                        TimerView(countTo: 121)
                        .environmentObject(matchManager)
                        .padding(.trailing, 20)

                    }

                    Text(isDisabled ? "Mencari Barang" :"Ketemu!")
                        .font(.custom("Chalkboard-Bold", size: 20))
                        .padding(8)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 8.0
                            )
                            .fill(isDisabled ? .white : Color.skyBlue)
                            .opacity(isDisabled ? 0.5 : 1)
                        )

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
                                    .foregroundColor(Color("DarkRed"))
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

                        }
                        .padding(.top, 22)
                        .padding(.bottom, 48)
                        .padding(.horizontal, 20)
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
