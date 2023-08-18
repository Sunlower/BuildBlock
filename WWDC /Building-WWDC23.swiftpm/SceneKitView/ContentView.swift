
import UIKit
import SceneKit
import SwiftUI

struct ContentView: View {

    @State private var selectedModelPlacement: Model?
    @State var topPosition: CGPoint = .zero
    @State var popupOne: Bool = false

    private var models: [Model] = {
        let filemanager = FileManager.default

        guard let path = Bundle.main.resourcePath,
                let files = try? filemanager.contentsOfDirectory(atPath: path)
        else {
            return []
        }

        var availableModels: [Model] = []
        for filename in files where filename.hasSuffix("scn"){
            if filename != "MainScene.scn" {
                let modelName = filename.replacingOccurrences(of: ".scn", with: "")
                let model = Model(modelName: modelName)
                availableModels.append(model!)
            }
        }

        return availableModels
    }()
    

    var body: some View {
            ZStack(alignment: .topTrailing) {

                ZStack(alignment: .bottom) {

                    GameViewController(selectedModelPlacement: $selectedModelPlacement, topPosition: $topPosition)

                    ViewPickerModel( models: models, selectedModelPlacement: $selectedModelPlacement, topPosition: $topPosition)
                }
                .ignoresSafeArea()

                HStack {
                    Button {
                        popupOne = true
                    } label: {
                        Image(systemName: "questionmark.bubble.fill")
                            .font(.title)
                            .foregroundColor(.accentColor)
                    }
                    .padding(50)

                    Spacer()
                    
                    NavigationLink {
                        ContentARView()
                    } label: {
                        Image(systemName: "arkit")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                            .foregroundColor(.accentColor)
                    }
                    .padding(50)
                }

            }
            .overlay{
                PopupView(popupOne: $popupOne, help: """
                ▪️ Drag blocks onto the scene and build your castle.

                ▪️ If you want to delete, press the desired block.
                """)
            }
            .navigationBarBackButtonHidden(true)
        
    }

}
