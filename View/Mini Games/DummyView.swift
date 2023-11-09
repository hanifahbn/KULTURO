import SwiftUI

struct DummyView: View {
    @EnvironmentObject var matchManager: MatchManager
    @State private var refreshTrigger = false
    
    @State var text = "helow"
    
    var body: some View {
        VStack {
            Text("Tampilan SwiftUI yang ingin Anda atur ulang")
                .padding()

            Text(text)
                .padding()
            
            Button(action: {
                self.refreshTrigger.toggle() // Ubah nilai untuk memicu pembaruan
            }) {
                Text("Atur Ulang Tampilan")
            }
        }
        .onAppear {
            text = "hai ini yah"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                text = "berubah"
                matchManager.gameStatus = .empty
            }
            matchManager.gameStatus = .dummy
        }
    }
}



#Preview {
    DummyView()
        .environmentObject(MatchManager())
}
