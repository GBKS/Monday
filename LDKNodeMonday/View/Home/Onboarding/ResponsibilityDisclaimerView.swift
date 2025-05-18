import SwiftUI

struct ResponsibilityDisclaimerView: View {
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
            Text("You are fully in control of your bitcoin.")
                .padding()
            Spacer()
            Button("I understand") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct ResponsibilityDisclaimerView_Previews: PreviewProvider {
    static var previews: some View {
        ResponsibilityDisclaimerView(nextAction: {}, backAction: {})
    }
}
#endif
