import SwiftUI

struct DummyView: View {
    @State private var isSheet1Presented = false
    @State private var isSheet2Presented = false

    var body: some View {
        VStack {
            Button("Show Sheet 1") {
                isSheet1Presented = true
            }

            Button("Show Sheet 2") {
                isSheet2Presented = true
            }
        }
        .sheet(isPresented: Binding(
            get: { isSheet1Presented || isSheet2Presented }, // Logic to show either of the sheets
            set: { shouldShow in
                if !shouldShow {
                    isSheet1Presented = false
                    isSheet2Presented = false
                }
            }
        )) {
            if isSheet1Presented {
                Sheet1View(isSheet1Presented: $isSheet1Presented, isSheet2Presented: $isSheet2Presented)
            } else if isSheet2Presented {
                Sheet2View(isSheet2Presented: $isSheet2Presented)
            }
        }
    }
}

struct Sheet1View: View {
    @Binding var isSheet1Presented: Bool
    @Binding var isSheet2Presented: Bool

    var body: some View {
        Text("This is Sheet 1")
        Button("Show Sheet 2") {
            isSheet1Presented = false
            isSheet2Presented = true
        }
        .presentationDetents([.height(190)])
        Button("Dismiss") {
            isSheet1Presented = false
        }
    }
}

struct Sheet2View: View {
    @Binding var isSheet2Presented: Bool

    var body: some View {
        Text("This is Sheet 2")
        Button("Dismiss") {
            isSheet2Presented = false
        }
        .presentationDetents([.height(190)])
    }
}


#Preview {
    DummyView()
}
