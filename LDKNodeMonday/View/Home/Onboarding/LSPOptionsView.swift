import SwiftUI
import BitcoinUI

struct LSPOptionsView: View {
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
                    Text("Choose a provider")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("They help you stay connected to the lightning network for fast and low-fee payments.")
                        .font(.custom("SFProRounded-Regular", size: 21))
                        .foregroundColor(Color(red: 119/255, green: 119/255, blue: 119/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .lineSpacing(4)
                }
                .padding(.top, 0)

                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#if DEBUG
struct LSPOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        LSPOptionsView(nextAction: {}, backAction: {})
    }
}
#endif
