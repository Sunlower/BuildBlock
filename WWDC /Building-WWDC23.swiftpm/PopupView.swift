import Foundation
import SwiftUI

struct PopupView: View {
    @Binding var popupOne: Bool
    var help: String

    var body: some View {
        if popupOne {
            VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.7)
                .overlay {
                    popStageOne
                        .transition(.scale)
                }
        }
    }

    var popStageOne: some View {
        VStack(){
            VStack{
                Text("Help")
                    .padding(10)
                    .foregroundStyle(Color.init(red: 32/255, green: 49/255, blue: 55/255))
                    .font(.system(size: 36, weight: .medium, design: .rounded))
                Divider()
                    .foregroundColor(.black)
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5)
                    .padding(.bottom, 10)
                Text(help)
                    .foregroundStyle(Color.init(red: 32/255, green: 49/255, blue: 55/255))
                    .font(.system(size: 26, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Button(action: {
                withAnimation {
                    popupOne = false
                }
            }) {
                    Text("Ok")
                        .frame(width: UIScreen.main.bounds.width/3, height: 45)
                        .font(.system(size: 30, weight: .bold))
                        .background(Color(.white))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.top, 15)

            }
            .padding(15)

        }
        .frame(width: UIScreen.main.bounds.width/2.5) //tamanho popup
        .background {
            Rectangle()
                .fill(Color.init(red:105/255, green:171/255, blue: 219/255))
                .foregroundColor(.black)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 30)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
