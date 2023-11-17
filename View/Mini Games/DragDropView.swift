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
    @State private var offset: CGFloat = 0.0
    @State var items = toolList.compactMap { tool in
        tool.image != nil ? tool: nil
    }
    @State var isAnimationDrag = false
    @State var currentIndex = 0
    @State private var isTutorialShown = true //nilai awal true
    @State var isSuccess: Bool = false
    @State private var currentSheet: SheetType? = nil
    @State private var isSheetPresented: Bool = false
    @State private var isAnimating : Bool = false
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
                    VStack{
                        HStack(spacing: -100){
                            Text("Geserlah barang-barang yang dibutuhkan untuk menyerahkannya ke Kepala Desa.")
                                .foregroundStyle(.white)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .padding(30)
                            
                            Image("DropTutorial")
                        }
                        Image("DragTutorial")
                            .padding(.leading, 80)
                            .offset(y: offset)
                            .opacity(isAnimating ? 0 : 1)
                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0), value: offset)
                            .onAppear {
                                withAnimation {

                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        isAnimating = true
//                                        offset = 0.0
                                        offset = -400.0
                                    }
                                }
                            }
                    }
                    .padding(.top, 50)
                    
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
                            } else {
                                ZStack{
                                    Image("HalfDesaBroken")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .opacity(0.8)
                                        .blur(radius: 2)
                                    Image("KadesHalf")
                                        .resizable()
                                        .frame(width: 350, height: 300)
                                        .padding(.top, 50)
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
                        TimerView(countTo: 31)
                            .environmentObject(matchManager)
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
            //            matchManager.startTimer(time: 31)
            items.shuffle()
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
    
    let hapticViewModel = HapticViewModel()
    
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
        //            .frame(width: 100, height: 100)
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
    }
    
    func askItem() {
        
        if position.height < -80 {
            if imageTool.bahasaName == items[currentIndex].bahasaName  {
                items = items.filter { tool in
                    return tool.image != imageTool.bahasaName
                }
                
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                if items.count == 0 {
                    askItems = true
                } else {
                    position =  CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY))
                }
                
                playerViewModel.playAudio(fileName: "Correct")
                hapticViewModel.simpleSuccess()
                //                }
            } else {
                hapticViewModel.simpleError()
                position =  CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY))
                
                playerViewModel.playAudio(fileName: "Wrong")
            }
            
        } else if position.width > 170 || position.width < -170 {
        }
    }
}
