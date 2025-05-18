import SwiftUI

struct BackupInformationView: View {
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
            Text("Your wallet is being backed up automatically to iCloud.")
                .padding()
            Spacer()
            Button("Sounds good") {
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct BackupInformationView_Previews: PreviewProvider {
    static var previews: some View {
        BackupInformationView(nextAction: {}, backAction: {})
    }
}
#endif
