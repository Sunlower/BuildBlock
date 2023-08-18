
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView {

    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        let focusSquare = FocusEntity(on: self, style: .classic(color: .white))
        focusSquare.setAutoUpdate(to: true)
        self.setupARView()
    }

    @objc required dynamic init?(coder decoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic

        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }

        self.session.run(config)
    }
}
