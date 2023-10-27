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
    @State var item = ["Ember", "Sapu", "Tisu","Kapak","Palu"]
    @State var currentIndex = 0
    var body: some View {
        ZStack{
            Color.ungu
                .ignoresSafeArea()
            Button("next") {
                router.path.append(.pasirStories)
            }
            ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: "Ember")
            ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: "Sapu")
            ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: "Kapak")
            ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: "Palu")
            ItemDrag(askItems: $askItems, askItems2: $askItems2, currentIndex: $currentIndex, imageTool: "Tisu")
            if askItems {
                Text("Terimakasih")
                    .font(.system(size: 50, weight: .semibold))
            } else if askItems2 {
                Text("Item Pindah")
                    .font(.system(size: 50, weight: .semibold))
            }
            VStack{
                Spacer()
                HStack(spacing: -60){
                    Image("Office")
                        .zIndex(1)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4)
                        .frame(width: 300, height: 110)
                        .overlay {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.gray)
                                VStack(alignment: .leading){
                                    Text("Tolong Ambilkan")
                                    Text(item[currentIndex])
                                        .foregroundStyle(.red)
                                }.font(.system(size: 20, weight: .bold))
                            }
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
    @State var imageTool: String
    @State var exceedCount = 0
    
    init(askItems: Binding<Bool>, askItems2: Binding<Bool>, currentIndex: Binding<Int>, imageTool: String) {
        let minX = -150.0 // Adjust this value for the minimum X-coordinate
        let maxX = 150.0  // Adjust this value for the maximum X-coordinate
        let minY = -150.0 // Adjust this value for the minimum Y-coordinate
        let maxY = 150.0  // Adjust this value for the maximum Y-coordinate
        
        self._position = State(initialValue: CGSize(width: Double.random(in: minX...maxX), height: Double.random(in: minY...maxY)))
        self._askItems = askItems
        self._askItems2 = askItems2
        self._currentIndex = currentIndex
        self.imageTool = imageTool
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
            print("masuk")
            currentIndex = Int.random(in: 0...2)
        } else if position.width > 170 || position.width < -170 {
            print("Kirim Barang")
            // askItems2 = true
        }
    }
}
