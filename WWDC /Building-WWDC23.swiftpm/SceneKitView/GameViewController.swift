
import SceneKit
import SwiftUI


struct GameViewController: UIViewRepresentable {
    @Binding var selectedModelPlacement: Model?
    @Binding var topPosition: CGPoint
    var sceneView = CustonScene(frame: .zero)

    func makeUIView(context: Context) -> SCNView {

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {

        if let model = self.selectedModelPlacement {

            self.addRandomGeometryNode(to:sceneView.scene, withGeometryNames: model, position: SCNVector3(topPosition.x * 0.09, 0.05, 0))

            DispatchQueue.main.async {
                selectedModelPlacement = nil
            }
        }else {

            }
    }


    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }


    func addRandomGeometryNode(to scene: SCNScene?, withGeometryNames geometryName: Model, position: SCNVector3) {
        guard let scene = scene else {
            return
        }

            let geometry = SCNScene(named: "\(geometryName.modelName).scn")?.rootNode.childNodes.first?.geometry ?? SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
            let geometryNode = SCNNode(geometry: geometry)
            geometryNode.name = geometryName.modelName
            if geometryNode.name == "Retangulo" || geometryNode.name == "Ponte" || geometryNode.name == "TrianguloGrandeTorto" || geometryNode.name == "TrianguloGrande"  {
                geometryNode.scale = SCNVector3(2, 1, 1)
            }
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometryNode.physicsBody?.friction = 0.5
        geometryNode.physicsBody?.isAffectedByGravity = true
            geometryNode.physicsBody?.mass = 0.3
            geometryNode.physicsBody?.damping = 1
            geometryNode.physicsBody?.charge = 0
            geometryNode.physicsBody?.restitution = 0

            geometryNode.position = position
        print(position)
            scene.rootNode.addChildNode(geometryNode)
            
           
    }
}
