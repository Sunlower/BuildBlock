import Foundation
import SwiftUI


struct InicialScreen: View {

    var body: some View {

        NavigationStack {
            VStack() {

                Spacer()

                Image("name")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/1.5, height: 150)

                Spacer()
                
                NavigationLink {
                    ContentView()
                } label: {
                    Text("PLAY")
                        .frame(width: UIScreen.main.bounds.width/3, height: 45)
                        .font(.system(size: 30, weight: .bold))
                        .background(Color(.white))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.top, 15)
                }
                .padding(20)
                Spacer()
            }
            .background(
                Image("bg")
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .ignoresSafeArea()
        }
        .onAppear{
            playSound(name: "bg", exten: "mp3", numb: -1, volume: 1.0)
        }
    }
}
