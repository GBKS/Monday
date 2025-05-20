import SwiftUI
import BitcoinUI

struct FeaturesView: View {
    @State private var imageY: CGFloat = 0
    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 70/255, green: 140/255, blue: 129/255),
                    Color(red: 146/255, green: 173/255, blue: 153/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Absolutely positioned image using imageY
            GeometryReader { geo in
                Image("features") // Use your image name here
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
                    Text("There’s more... but you’ll get to it later")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("Your wallet has more features to explore. Take your time, we’ve now got the basics covered.")
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
                    Text("Let’s go")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color(red: 63/255, green: 129/255, blue: 117/255))
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                }
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
struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(nextAction: {}, backAction: {})
    }
}
#endif
