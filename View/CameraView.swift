//
//  CameraView.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 26/10/23.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var router : Router
    var body: some View {
        VStack{
            Text("Camera Game")
            Button("Next") {
                router.path.append(.bantuDesa)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CameraView()
}
