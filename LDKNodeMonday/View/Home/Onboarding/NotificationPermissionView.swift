import SwiftUI
import BitcoinUI

struct NotificationPermissionView: View {
    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        ZStack {
            // Background gradient overlay (optional, can adjust opacity if needed)
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 244/255, green: 118/255, blue: 48/255),
                    Color(red: 249/255, green: 169/255, blue: 69/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Background image for the whole screen
            GeometryReader { geo in
                Image("coins")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .ignoresSafeArea()
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
                    Text("Want to be notified when you receive bitcoin?")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("We can bug you right away. Or not.")
                        .font(.custom("SFProRounded-Regular", size: 21))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .lineSpacing(4)
                }
                .padding(.top, 0)

                Spacer()

                Button(action: nextAction) {
                    Text("Let me know")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color(red: 142/255, green: 28/255, blue: 1/255))
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
                    Text("Nope")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                }
                .background(
                    ZStack {
                        Color(red: 142/255, green: 28/255, blue: 1/255).opacity(0.05)
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
        }
        .coordinateSpace(name: "container")
    }
}

#if DEBUG
struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionView(nextAction: {}, backAction: {})
    }
}
#endif
