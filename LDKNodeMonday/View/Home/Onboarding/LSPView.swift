import SwiftUI

struct LSPView: View {
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
            Text("The application will rely on an LSP (Lightning Service Provider) for connecting to the lightning network.")
                .padding()
            Spacer()
            Button("Great") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct LSPView_Previews: PreviewProvider {
    static var previews: some View {
        LSPView(nextAction: {}, backAction: {})
    }
}
#endif
