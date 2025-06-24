import SwiftUI
import BitcoinUI

struct BackupDetailsView: View {
    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        ZStack {
            // Content
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Button(action: backAction) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 141/255, green: 34/255, blue: 110/255))
                            .font(.title2)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .frame(height: 56)
                .padding(.top, 8)
                
                // Header
                VStack(spacing: 16) {
                    Text("Let’s back up")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("You don’t want to lose your bitcoin, and backing your wallet is important for that. There are three parts to this.")
                        .font(.custom("SFProRounded-Regular", size: 21))
                        .foregroundColor(Color(red: 119/255, green: 119/255, blue: 119/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .lineSpacing(4)
                }
                .padding(.top, 0)

                Spacer()

                Button(action: nextAction) {
                    Text("Next")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 141/255, green: 34/255, blue: 110/255))
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#if DEBUG
struct BackupDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BackupDetailsView(nextAction: {}, backAction: {})
    }
}
#endif
