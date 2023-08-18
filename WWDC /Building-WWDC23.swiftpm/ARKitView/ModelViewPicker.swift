
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ModelViewPicker: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?

    var models: [Model]

    var body : some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models.count) { index in
                    Button {
                        selectedModel = models[index]
                        isPlacementEnabled.toggle()
                    } label: {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 40)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(8)

                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(30)
        .background(Color.black.opacity(0.5))
    }

}
