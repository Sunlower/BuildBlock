
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

extension ARView {
    func enableObjectsRemoval() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }

    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer){
        let location = recognizer.location(in: self)

        if let entity = self.entity(at: location) {
            if let anchorEntity = entity.anchor{
                anchorEntity.removeFromParent()
            }
        }
    }

    func enableTapGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    func handleTap(recognizer: UITapGestureRecognizer){
        let tapLocation = recognizer.location(in: self)

        guard let rayResult = self.ray(through: tapLocation) else { return }

        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)

        if let firstResult = results.first {

            var position = firstResult.position
            position.y += 0.3/2

            placeCube(at: position)


        } else {
            let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)

            if let firstResult = results.first {
                let position = simd_make_float3(firstResult.worldTransform.columns.3)
                placeCube(at:position)

            }

        }
    }

    func placeCube(at position: SIMD3<Float>) {
        let mesh = MeshResource.generateBox(size: 0.3)
        let material = SimpleMaterial(color: UIColor.randomColor(), isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        modelEntity.generateCollisionShapes(recursive: true)

        let anchorEntity = AnchorEntity(world: position)
        anchorEntity.addChild(modelEntity)

        self.scene.addAnchor(anchorEntity)
    }
}
extension UIColor {
    class func randomColor() -> UIColor {
        let colors: [UIColor] = [.white, .blue, .black, .purple, .yellow, . orange, .red, .gray, .green]

        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))

        return colors[randomIndex]
    }
}
