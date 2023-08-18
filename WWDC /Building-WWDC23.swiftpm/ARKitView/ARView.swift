

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentARView : View {

    @State private var isPlacementEnable = false
    @State private var selectedModel: Model?
    @State private var selectedModelPlacement: Model?
    @State var popupOne: Bool = false

    private var models: [Model] = {
        let filemanager = FileManager.default

        guard let path = Bundle.main.resourcePath,
                let files = try? filemanager.contentsOfDirectory(atPath: path)
        else {
            return []
        }

        var availableARModels: [Model] = []
        for filename in files where filename.hasSuffix("usdz"){
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)

            availableARModels.append(model!)
        }

        return availableARModels
    }()


    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                ARViewContainer(selectedModelPlacement: $selectedModelPlacement)

                Button {
                    popupOne = true
                } label: {
                    Image(systemName: "questionmark.bubble.fill")
                        .font(.title)
                        .foregroundColor(.accentColor)
                }
                .padding(50)

            }

            if !isPlacementEnable {
                ModelViewPicker(isPlacementEnabled: $isPlacementEnable, selectedModel: $selectedModel, models: self.models)
            } else {
                PlacementButtonsView(isPlacementEnabled: $isPlacementEnable, selectedModel: $selectedModel, selectedModelPlacement: $selectedModelPlacement)
            }

        }.ignoresSafeArea()
            .overlay{
                PopupView(popupOne: $popupOne, help:  """
                           ▪️ To add the blocks, you must choose a place where the focus is with the borders filled in, choose only one block of each and click confirm.

                           ▪️ To delete, click and hold on top of the block

                           ▪️ Rotating, relocating and scaling are also supported.
                           """
                )
            }
    }
}
