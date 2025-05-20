import SwiftUI
import LDKNode
import AVKit

struct CoverScreen: View {
    var nextAction: () -> Void
    var backAction: () -> Void

    @ObservedObject var viewModel: OnboardingViewModel

    @State private var showingOnboardingViewErrorAlert = false
    @State private var showingNetworkSettingsSheet = false
    @State private var showingImportWalletSheet = false
    @State private var animateContent = false

    private let player: AVQueuePlayer
    private var looper: AVPlayerLooper?

    init(nextAction: @escaping () -> Void, backAction: @escaping () -> Void, viewModel: OnboardingViewModel) {
        self.nextAction = nextAction
        self.backAction = backAction
        self.viewModel = viewModel

        if let url = Bundle.main.url(forResource: "cover", withExtension: "mp4") {
            let item = AVPlayerItem(url: url)
            let queuePlayer = AVQueuePlayer(items: [item])
            let looper = AVPlayerLooper(player: queuePlayer, templateItem: item)
            queuePlayer.isMuted = true
            queuePlayer.play()
            self.player = queuePlayer
            self.looper = looper // <-- keep a strong reference
        } else {
            self.player = AVQueuePlayer()
            self.looper = nil
        }
    }

    var body: some View {
        ZStack {
            Color(red: 204/255, green: 196/255, blue: 209/255)
                .ignoresSafeArea()

            // Placeholder image or color
            Image("cover")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            // Video background
            VideoPlayer(player: player)
                .ignoresSafeArea()
                .onAppear {
                    player.play()
                    player.isMuted = true
                }
                .disabled(true) // Prevents interaction
                .overlay(Color.clear) // Prevents accidental tap showing controls
                .allowsHitTesting(false) // Ensures no interaction, so controls never show

            // Foreground content
            VStack {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            showingNetworkSettingsSheet.toggle()
                        },
                        label: {
                            HStack(spacing: 5) {
                                Text(
                                    viewModel.walletClient.network.description
                                        .capitalized
                                )
                                .foregroundColor(.white)
                                .opacity(animateContent ? 1 : 0)
                                .offset(x: animateContent ? 0 : 100)
                                Image(systemName: "gearshape")
                                    .foregroundColor(.white)
                                    .opacity(animateContent ? 1 : 0)
                                    .offset(x: animateContent ? 0 : 100)
                            }
                        }
                    )
                    .sheet(isPresented: $showingNetworkSettingsSheet) {
                        NavigationView {
                            NetworkSettingsView(walletClient: viewModel.$walletClient)
                        }
                    }
                }
                .fontWeight(.medium)
                .padding()
                .animation(.easeOut(duration: 0.5).delay(0.6), value: animateContent)

                Spacer()

                // Logo, name and description
                VStack {
                    Group {
                        Text("Bubble wallet")
                            .font(.custom("SFProRounded-Semibold", size: 36))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                        Text("Just Bitcoin. Soft on the outside, serious underneath.")
                            .font(.custom("SFProRounded-Regular", size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .lineSpacing(4)
                    }
                    .opacity(animateContent ? 1 : 0)
                    .offset(y: animateContent ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: animateContent)
                }
                .padding(.bottom, 32)

                // Buttons for creating and importing wallet
                Button(action: nextAction) {
                    Text("Create wallet")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color(red: 198/255, green: 86/255, blue: 129/255))
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 16)

                Button(action: {
                    showingImportWalletSheet.toggle()
                }) {
                    Text("Import wallet")
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
                .sheet(isPresented: $showingImportWalletSheet) {
                    ImportWalletView().environmentObject(viewModel)
                }
            }
            .padding(.bottom, 32)
            .frame(maxHeight: .infinity)
        }
        .alert(isPresented: $showingOnboardingViewErrorAlert) {
            Alert(
                title: Text(viewModel.onboardingViewError?.title ?? "Unknown error"),
                message: Text(viewModel.onboardingViewError?.detail ?? "No details"),
                dismissButton: .default(Text("OK")) {
                    viewModel.onboardingViewError = nil
                }
            )
        }
        .onAppear {
            withAnimation {
                animateContent = true
            }
            player.play()
            player.isMuted = true
        }
    }
}

#if DEBUG
struct CoverScreen_Previews: PreviewProvider {
    static var previews: some View {
        CoverScreen(
            nextAction: {},
            backAction: {},
            viewModel: OnboardingViewModel(walletClient: .constant(WalletClient(appMode: .mock)))
        )
    }
}
#endif