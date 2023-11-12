//
//  DragDropView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 26/10/23.
//

import SwiftUI

struct DragDropView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @State var isModalPresented : Bool = false
    @State var askItems: Bool = false
    @State var askItems2: Bool = false
    
    @State var items = toolList.compactMap { tool in
        tool.image != nil ? tool: nil
    }
    
    @State var currentIndex = 0
    @State private var isTutorialShown = false //nilai awal true
    
    @State var isSuccess: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false
    
    enum SheetType {
        case dndSuccess
        case dndSuccessAll
        case lose
    }
    
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            if isTutorialShown {
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.8)
                    Text("Geserlah barang-barang yang dibutuhkan untuk menyerahkannya ke Kepala Desa.")
                        .foregroundStyle(.white)
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(30)
                }
                .animation(.easeIn(duration: 0.5), value: isTutorialShown)
                .zIndex(2)
            }
            ZStack{
                VStack{
                    Rectangle()
                        .opacity(0.3)
                        .overlay {
                            if(items.count != 0){
                                ZStack{
                                    Image("HalfDesaBroken")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .opacity(0.8)
                                        .blur(radius: 2)
                                    VStack{
                                        Spacer()
                                        ZStack{
                                            Image("TextBoxDragDrop")
                                                .padding(.bottom, 150)
                                                .padding(.trailing, 140)
                                                .overlay(content: {
                                                    HStack{
                                                        VStack {
                                                            Text("Tolong berikan")
                                                            HStack{
                                                                Text("saya")
                                                                Text("\(items[currentIndex].bahasaName)")
                                                                    .foregroundStyle(Color.red)
                                                            }
                                                            
                                                            Spacer()
                                                        }
                                                        .font(.custom("Chalkboard-Regular", size: 25))
                                                        .padding(.trailing, 150)
                                                    }
                                                    .padding(5)
                                                    
                                                })
                                            Image("KadesHalf")
                                                .resizable()
                                                .frame(width: 350, height: 300)
                                                .padding(.top, 100)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 350)
                        .ignoresSafeArea()
                    
                    
                    Spacer()
                }
                VStack{
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 110, height: 55)
                            .foregroundStyle(.white)
                            .opacity(0.5)
                            .overlay(content: {
                                HStack{
                                    Image("IconTimer")
                                    //                                        .font(.system(size: 25, weight: .bold))
                                    Text(matchManager.timeInString)
                                        .font(.system(size: 17, weight: .bold))
                                }
                            })
                            .padding(.trailing, 30)
                    }
                    
                    if(matchManager.isFinishedPlaying == 1 && !isSuccess){
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 230, height: 54)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                                .shadow(radius: 0, y: 5)
                                .overlay {
                                    HStack{
                                        Image(chosenCharacters[1].headImage)
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .padding(.bottom, 15)
                                        Text("Hei, lekaslah! Aku sudah selesai.")
                                            .font(.system(size: 15, weight: .bold))
                                    }
                                }
                                .padding(.top, 20)
                                .opacity(matchManager.isFinishedPlaying == 1 ? 1 : 0)
                                .animation(
                                    .linear.delay(1.0),
                                    value: matchManager.isFinishedPlaying == 1
                                )
                        }
                        .zIndex(3)
                    }
                    Spacer()
                }
                if(items.count != 0){
                    ForEach(items.indices, id: \.self) { item in
                        ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: $items[item], items: $items)
                    }
                }
                if askItems {
                    Text("Terimakasih")
                        .font(.system(size: 50, weight: .semibold))
                        .onAppear {
                            matchManager.isFinishedPlaying += 1
                            matchManager.synchronizeGameState("DragAndDropMission")
                            isSuccess = true
                        }
                        .hidden()
                } else if askItems2 {
                    Text("Item Pindah")
                        .font(.system(size: 50, weight: .semibold))
                }
                //                if(items.count != 0){
                //                    VStack{
                //                        HStack(spacing: -60) {
                //                            Image("Office")
                //                                .resizable()
                //                                .frame(width: 85, height: 87 )
                //                                .zIndex(1)
                //                                .padding(.top, -10)
                //
                //                            Rectangle()
                //                                .foregroundColor(.white)
                //                                .frame(width: 260, height: 76)
                //                                .background(.white.opacity(0.6))
                //                                .cornerRadius(16)
                //                                .overlay(
                //                                    ZStack{
                //                                        RoundedRectangle(cornerRadius: 16)
                //                                            .inset(by: 0.5)
                //                                            .stroke(Color(red: 0.15, green: 0.31, blue: 0.24).opacity(0.5), lineWidth: 1)
                //                                        VStack(alignment: .leading){
                //                                            Text("Tolong Ambilkan")
                //                                            Text(items[currentIndex])
                //                                                .foregroundStyle(.red)
                //                                        }.font(.system(size: 20, weight: .bold))
                //
                //                                            .padding(.leading, 36)
                //                                    }
                //                                )
                //                        }
                //                        Spacer()
                //                    }
                //                }
                
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Color.ungu
                    .ignoresSafeArea()
                switch currentSheet {
                case .dndSuccess:
                    ModalView(modalType: "DragAndDropSuccess", textButton: "Menunggu temanmu selesai...")
                        .environmentObject(matchManager)
                case .dndSuccessAll:
                    ModalView(modalType: "DragAndDropSuccess", textButton: "Lanjutkan")
                        .environmentObject(matchManager)
                case .lose:
                    ModalView(modalType: "Lose", backTo: .dragAndDrop)
                        .environmentObject(matchManager)
                case .none:
                    //                    ModalView(modalType: "Lose", backTo: .cameraGame)
                    //                        .environmentObject(matchManager)
                    VStack {
                        EmptyView()
                    }
                    .onAppear{
                        isSuccess.toggle()
                        isSuccess.toggle()
                    }
                }
            }
            .interactiveDismissDisabled()
            .presentationDetents([.height(190)])
        }
        .onAppear{
            //TImer
            matchManager.startTimer(time: 30)
        }
        .onTapGesture {
            isTutorialShown = false
        }
        .onChange(of: isSuccess) { _ in
            updateSheets()
        }
        .onChange(of: matchManager.isTimerRunning) { _ in
            updateSheets()
        }
        .onChange(of: matchManager.isFinishedPlaying) { _ in
            updateSheets()
        }
    }
    
    private func updateSheets() {
        if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying < 2 {
            currentSheet = .dndSuccess
            isSheetPresented = true
        } else if isSuccess && matchManager.isTimerRunning && matchManager.isFinishedPlaying == 2 {
            currentSheet = .dndSuccessAll
            isSheetPresented = true
        } else if isSuccess && !matchManager.isTimerRunning && matchManager.isFinishedPlaying < 2 {
            currentSheet = .lose
            isSheetPresented = true
        } else if !isSuccess && !matchManager.isTimerRunning {
            currentSheet = .lose
            isSheetPresented = true
        }
    }
    
}

#Preview {
    DragDropView()
        .environmentObject(MatchManager())
}

struct ItemDrag: View {
    @State var playerViewModel = PlayerViewModel()
    
    @State var dragOffset: CGSize = .zero
    @State var position: CGSize
    @Binding var askItems: Bool
    @Binding var askItems2: Bool
    @Binding var currentIndex: Int
    @Binding var items: [ToolBahasa]
    @Binding var imageTool: ToolBahasa
    
    @State var exceedCount = 0
    
    let minX = -150.0 // Adjust this value for the minimum X-coordinate
    let maxX = 150.0  // Adjust this value for the maximum X-coordinate
    let minY = 0.0 // Adjust this value for the minimum Y-coordinate
    let maxY = 300.0  // Adjust this value for the maximum Y-coordinate
    
    
    init(askItems: Binding<Bool>, askItems2: Binding<Bool>, currentIndex: Binding<Int>, imageTool: Binding<ToolBahasa>, items: Binding<[ToolBahasa]>) {
        
        self._position = State(initialValue: CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY)))
        self._askItems = askItems
        self._askItems2 = askItems2
        self._currentIndex = currentIndex
        self._imageTool = imageTool
        self._items = items
    }
    
    var body: some View {
        Image(imageTool.image!)
            .resizable()
            .frame(width: imageTool.width!, height: imageTool.height!)
            .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
            .gesture(DragGesture()
                .onChanged({ (value) in
                    self.dragOffset = value.translation
                })
                    .onEnded({ (value) in
                        self.position.width += value.translation.width
                        self.position.height += value.translation.height
                        self.dragOffset = .zero
                        askItem()
                    })
            )
            .onAppear{
//                print("Image : \(imageTool.image!) = \(position.width) - \(position.height)")
            }
    }
    
    func askItem() {
        
        if position.height < -80 {
            exceedCount += 1
            if exceedCount >= 5 {
                print("aw")
            }
            if imageTool.bahasaName == items[currentIndex].image  {
                items = items.filter { tool in
                    return tool.image != imageTool.bahasaName
                }
                
                if items.count == 0 {
                    askItems = true
                } else {
                    currentIndex = Int.random(in: 0...items.count - 1)
                }
            } else {
                position =  CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY))
                
                playerViewModel.playAudio(fileName: "Wrong")
            }
            
        } else if position.width > 170 || position.width < -170 {
        }
    }
}
