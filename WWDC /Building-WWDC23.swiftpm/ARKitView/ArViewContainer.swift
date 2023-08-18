
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedModelPlacement: Model?

    func makeUIView(context: Context) -> ARView {

        let arView = CustomARView(frame: .zero)

        arView.enableObjectsRemoval()

        return arView

    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = self.selectedModelPlacement {

            if let modelEntity = model.modelEntity{

                let screenCenter = CGPoint(x: uiView.bounds.midX, y: uiView.bounds.midY)
                guard let rayResult = uiView.ray(through: screenCenter) else { return }

                let resultsList = uiView.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)

                if let firstResult = resultsList.first {

                    let results = uiView.raycast(from: screenCenter, allowing: .estimatedPlane, alignment: .any)

                    if let firstResult = results.first {
                        var position = simd_make_float3(firstResult.worldTransform.columns.3)
                        position.y += Float(resultsList.count) * 0.12
                        modelEntity.generateCollisionShapes(recursive: true)

                        createModel(uiView: uiView, modelEntity: modelEntity, model: model, position: position)
                    }

                } else {
                    let results = uiView.raycast(from: screenCenter, allowing: .estimatedPlane, alignment: .any)

                    if let firstResult = results.first {
                        let position = simd_make_float3(firstResult.worldTransform.columns.3)
                        modelEntity.generateCollisionShapes(recursive: true)

                        createModel(uiView: uiView, modelEntity: modelEntity, model: model, position: position)
                    }
                }

            } else {
            }

            DispatchQueue.main.async {
                self.selectedModelPlacement = nil
            }
        }
    }

    func createModel(uiView:ARView, modelEntity: ModelEntity, model: Model, position: SIMD3<Float>) {
        modelEntity.generateCollisionShapes(recursive: true)
        let anchorEntity = AnchorEntity(plane: .any, classification: .any)
        anchorEntity.addChild(modelEntity)
        anchorEntity.name = model.modelName
        anchorEntity.scale = SIMD3(0.06, 0.06, 0.06)
        anchorEntity.generateCollisionShapes(recursive: true)
        uiView.installGestures([.translation,.scale,.rotation] ,for: modelEntity)

        uiView.enableObjectsRemoval()

        anchorEntity.position = position
        uiView.scene.addAnchor(anchorEntity)
    }

}
