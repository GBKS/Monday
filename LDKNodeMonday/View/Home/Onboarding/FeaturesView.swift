import SwiftUI

struct FeaturesView: View {
    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    backAction()
                }) {
                    Text("Back")
                }
                .padding()
                Spacer()
            }
            Spacer()
            Text("There are plenty of other features in the application. You will get to know them through your interactions.")
                .padding()
            Spacer()
            Button("Let's go") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(nextAction: {}, backAction: {})
    }
}
#endif
