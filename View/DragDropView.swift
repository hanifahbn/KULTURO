//
//  DragDropView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 26/10/23.
//

import SwiftUI

struct DragDropView: View {
    @EnvironmentObject var router : Router
    @State var askItems : Bool = false
    @State var askItems2 : Bool = false
    @State var items = ["Ember", "Sapu", "Tisu","Kapak","Palu"]
    @State var currentIndex = 0
    
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            Button("next") {
                router.path.append(.pasirStories)
            }
            
            if(items.count != 0){
                ForEach(items, id: \.self) { item in
                    ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: item, items: $items)
                }
            }
            
            if askItems {
                Text("Terimakasih")
                    .font(.system(size: 50, weight: .semibold))
            } else if askItems2 {
                Text("Item Pindah")
                    .font(.system(size: 50, weight: .semibold))
            }
            
            Spacer()
            
            if(items.count != 0){
                VStack{
                    Spacer()
                    HStack(spacing: -60) {
                        Image("Office")
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
                                    VStack(alignment: .leading){
                                        Text("Tolong Ambilkan")
                                        Text(items[currentIndex])
                                            .foregroundStyle(.red)
                                    }.font(.system(size: 20, weight: .bold))
                                    
                                        .padding(.leading, 36)
                                }
                            )
                        
                        
                    }
                }
            }
            
        }
    }
    
}

#Preview {
    DragDropView()
}

struct ItemDrag: View {
    @State var dragOffset: CGSize = .zero
    @State var position: CGSize
    @Binding var askItems: Bool
    @Binding var askItems2: Bool
    @Binding var currentIndex: Int
    @Binding var items: [String]
    @State var imageTool: String
    @State var exceedCount = 0
    
    let minX = -150.0 // Adjust this value for the minimum X-coordinate
    let maxX = 150.0  // Adjust this value for the maximum X-coordinate
    let minY = -150.0 // Adjust this value for the minimum Y-coordinate
    let maxY = 150.0  // Adjust this value for the maximum Y-coordinate
    
    
    init(askItems: Binding<Bool>, askItems2: Binding<Bool>, currentIndex: Binding<Int>, imageTool: String, items: Binding<[String]>) {
        
        self._position = State(initialValue: CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY)))
        self._askItems = askItems
        self._askItems2 = askItems2
        self._currentIndex = currentIndex
        self.imageTool = imageTool
        self._items = items
    }
    
    var body: some View {
        Image(imageTool)
            .frame(width: 100, height: 100)
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
        
        if position.height > 300 {
            exceedCount += 1
            if exceedCount >= 5 {
                print("aw")
            }
            if imageTool == items[currentIndex]  {
                items = items.filter{$0 != imageTool}
                
                if items.count == 0 {
                    askItems = true
                } else {
                    currentIndex = Int.random(in: 0...items.count - 1)
                }
            } else {
                position =  CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY))
            }
            
        } else if position.width > 170 || position.width < -170 {
            print("Kirim Barang")
        }
    }
}
