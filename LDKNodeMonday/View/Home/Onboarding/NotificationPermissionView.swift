import SwiftUI

struct NotificationPermissionView: View {
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
            Text("Enable notifications to be informed of new payments.")
                .padding()
            Spacer()
            Button("Next") {
                // Trigger OS-notification request here
                nextAction()
            }
            .buttonStyle(BitcoinFilled(tintColor: .accent, isCapsule: true))
            .padding()
        }
    }
}

#if DEBUG
struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionView(nextAction: {}, backAction: {})
    }
}
#endif
