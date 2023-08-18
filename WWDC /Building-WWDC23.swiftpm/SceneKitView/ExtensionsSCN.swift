import UIKit
import SceneKit
import SwiftUI

extension SCNView {

    func enableObjectsRemoval() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }

    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        let hitList = self.hitTest(location, options: nil)
        if let hitObject = hitList.first {
            if hitObject.node.name != "floor" {
                let node = hitObject.node
                node.removeFromParentNode()
            }
        }

    }

    func panGesture (){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        let translation = gesture.translation(in: self)
        let hitResults = self.hitTest(location)

        if let firstResult = hitResults.first?.node, firstResult.name != "floor" {
            gestureStateFirstHit( firstResult: firstResult)
        }


        func gestureStateFirstHit(firstResult: SCNNode){

            switch gesture.state {
                case .changed:
                    changedStateObject(firstResult: firstResult)
                default:
                    break
            }
        }

        func changedStateObject(firstResult: SCNNode) {
            let newPos = SCNVector3(firstResult.position.x + Float(translation.x) * 0.03, firstResult.position.y - Float(translation.y) * 0.03, 0)
            firstResult.position = newPos
            gesture.setTranslation(.zero, in: self)
        }
    }

}



