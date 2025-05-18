import SwiftUI

struct UnitFormatView: View {
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
            Text("Choose your unit format:")
                .padding()
            Button("Bitcoin") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
            Button("Satoshi") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
            Button("Simplified") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
            Spacer()
            Button("Next") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct UnitFormatView_Previews: PreviewProvider {
    static var previews: some View {
        UnitFormatView(nextAction: {}, backAction: {})
    }
}
#endif
