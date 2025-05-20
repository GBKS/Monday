import SwiftUI
import BitcoinUI

struct LSPView: View {
    @State private var imageY: CGFloat = 0
    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 194/255, green: 153/255, blue: 176/255),
                    Color(red: 201/255, green: 155/255, blue: 182/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Absolutely positioned image using imageY
            GeometryReader { geo in
                Image("lsp") // Use your image name here
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
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .frame(height: 56)
                .padding(.top, 8)
                
                // Header
                VStack(spacing: 16) {
                    Text("Time to move fast.")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("Lightning lets you send Bitcoin instantly with tiny fees. We’ll set you up with a provider so you’re good to go.")
                        .font(.custom("SFProRounded-Regular", size: 21))
                        .foregroundColor(.white)
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
                    Text("Use default")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color(red: 160/255, green: 99/255, blue: 147/255))
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 16)

                Button(action: nextAction) {
                    Text("View options")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                }
                .background(
                    ZStack {
                        Color(red: 160/255, green: 99/255, blue: 147/255).opacity(0.05)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .background(.ultraThinMaterial)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 1)
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
struct LSPView_Previews: PreviewProvider {
    static var previews: some View {
        LSPView(nextAction: {}, backAction: {})
    }
}
#endif
