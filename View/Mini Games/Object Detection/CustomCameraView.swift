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

    @State var isDisabled: Bool = false

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


                ZStack {
                    if(isDisabled){
                        Rectangle().background(.ultraThinMaterial)
                    }else{
                        Rectangle().foregroundStyle(Color.skyBlue)
                    }
                    RoundedRectangle(cornerRadius: 81)
                        .frame(width: 350, height: 421)
                        .padding(.bottom, 160)
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
                .ignoresSafeArea()


            VStack{

                HStack(){
                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 110, height: 55)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .overlay(content: {
                            HStack{
                                Image("IconTimer")
                                    .font(.system(size: 25, weight: .bold))
//                                Text(matchManager.timeInString)
//                                    .font(.system(size: 17, weight: .bold))
                            }
                        })
                }
                .padding(.trailing, 30)

                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 112, height: 25)
                        .foregroundStyle(isDisabled ? .white : .skyBlue)
                        .opacity(isDisabled ? 0.5 : 1)
                        .overlay(content: {
                            HStack{
                                Text(isDisabled ? "Mencari Barang" :"Ketemu!")
                                    .font(.custom("Chalkboard-Bold", size: 12))
                                    .foregroundStyle(.black)
                            }
                        }).padding(.top, 28)

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
                    } .padding(.bottom, -40)

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

#Preview {
    ObjectDetectionGame()
        .environmentObject(MatchManager())
}
