import SwiftUI
import BitcoinUI

struct BackupInformationView: View {
    @State private var imageY: CGFloat = 0
    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 252/255, green: 168/255, blue: 203/255),
                    Color(red: 229/255, green: 211/255, blue: 240/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Absolutely positioned image using imageY
            GeometryReader { geo in
                Image("cloud") // Use your image name here
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                    .position(x: geo.size.width / 2, y: imageY == 0 ? geo.size.height / 2 : imageY)
            }

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
                    Text("Let’s keep your wallet safe.")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(Color(red: 141/255, green: 34/255, blue: 110/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("We’ll encrypt your wallet and back it up to iCloud—so you can recover your funds if you lose or replace your phone.")
                        .font(.custom("SFProRounded-Regular", size: 21))
                        .foregroundColor(Color(red: 141/255, green: 34/255, blue: 110/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .lineSpacing(4)
                }
                .padding(.top, 0)

                // The block whose midY we want
                GeometryReader { spacerGeo in
                    let midY = spacerGeo.frame(in: .named("container")).midY
                    Color.clear
                        .preference(key: ImageYPreferenceKey.self, value: midY)
                }
                .frame(maxHeight: .infinity)

                Button(action: nextAction) {
                    Text("Sounds good")
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
                .padding(.bottom, 16)

                Button(action: nextAction) {
                    Text("View options")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color(red: 141/255, green: 34/255, blue: 110/255))
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                }
                .background(
                    ZStack {
                        Color.white.opacity(0.05)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 141/255, green: 34/255, blue: 110/255), lineWidth: 1)
                )
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .frame(maxHeight: .infinity)
            .onPreferenceChange(ImageYPreferenceKey.self) { y in
                imageY = y
            }
        }
        .coordinateSpace(name: "container")
    }
}

private struct ImageYPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#if DEBUG
struct BackupInformationView_Previews: PreviewProvider {
    static var previews: some View {
        BackupInformationView(nextAction: {}, backAction: {})
    }
}
#endif
