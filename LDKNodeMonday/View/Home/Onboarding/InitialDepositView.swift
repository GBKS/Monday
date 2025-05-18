import SwiftUI

struct InitialDepositView: View {
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
            Text("Make an initial deposit to have funds in your wallet.")
                .padding()
            // QR code of the first bitcoin address should be displayed here
            Spacer()
            Button("Share") {
                // Activate the native share sheet for sharing the bitcoin address as a BIP21 URI
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
            Button("Do this later") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct InitialDepositView_Previews: PreviewProvider {
    static var previews: some View {
        InitialDepositView(nextAction: {}, backAction: {})
    }
}
#endif
