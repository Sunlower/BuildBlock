import UIKit
import SceneKit
import SwiftUI

class CustonScene: SCNView {

    var temp = CGFloat(0)

    required override init(frame frameRect: CGRect) {
        super.init(frame: frameRect, options: nil)
        guard let scene = SCNScene(named: "MainScene.scn") else {
          return
        }
        self.scene = scene
        self.allowsCameraControl = true
        self.isPlaying = true
        self.autoenablesDefaultLighting = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        

        self.panGesture()
        self.enableObjectsRemoval()
        self.pinchGesture()
   
    }

    @objc required dynamic init?(coder decoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    func pinchGesture(){
        let handleGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(gesture:)))

        self.addGestureRecognizer(handleGesture)
    }

    @objc func handlePinchGesture(gesture: UIPinchGestureRecognizer) {
        var location = gesture.location(in: self)
        
        if let cameraNode = self.pointOfView {

            let emptyNode = SCNNode()
            emptyNode.addChildNode(cameraNode)
            self.scene!.rootNode.addChildNode(emptyNode)
            
            switch gesture.state {
            case .changed:
                    let scale = gesture.scale
                    emptyNode.scale.x = Float(scale)
                    emptyNode.scale.y = Float(scale)
                    emptyNode.scale.z = Float(scale)
                    emptyNode.position = SCNVector3(location.x * 0.03, 0.5, 0)
            case .ended:
                    let scale = gesture.scale
                        emptyNode.scale.x = Float(scale)
                        emptyNode.scale.y = Float(scale)
                        emptyNode.scale.z = Float(scale)
                    emptyNode.position = SCNVector3(location.x * 0.03, 0.5, 0)
            default:
                break
            }
        }

    }

}

