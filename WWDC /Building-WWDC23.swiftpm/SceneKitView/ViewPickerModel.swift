import UIKit
import SceneKit
import SwiftUI

struct ViewPickerModel: View {
    var models: [Model]?
    @Binding var selectedModelPlacement: Model?
    @Binding var topPosition: CGPoint

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models!.count) { index in
                    Image(uiImage: UIImage(named: self.models![index].modelName)!)
                        .resizable()
                        .frame(height: 80)
                        .aspectRatio(1/1, contentMode: .fit)
                        .background(Color.clear)
                        .cornerRadius(8)
                        .gesture(
                            DragGesture(minimumDistance: CGFloat(10.0), coordinateSpace: .local)
                                .onChanged({ newValue in
                                    topPosition = newValue.location

                                })
                                .onEnded{ newValue in
                                    selectedModelPlacement = models![index]
                                    print(topPosition)
                                    playSound(name: "musicBox", exten: "mp3", numb: 0, volume: 0.1)
                                }
                        )
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

