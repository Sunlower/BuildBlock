
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct PlacementButtonsView: View{
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var selectedModelPlacement: Model?

    var body: some View {
        HStack {

            //Cancel button
            Button {
                isPlacementEnabled.toggle()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 40, height: 40)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(30)
            }

            //Confirm button
            Button {
                selectedModelPlacement = selectedModel
                isPlacementEnabled.toggle()
                playSound(name: "musicBox", exten: "mp3", numb: 0, volume: 0.1)
            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 40, height: 40)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(30)
            }

        }
    }
}
