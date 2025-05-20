import LDKNode
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Binding var walletClient: WalletClient
    @Published var onboardingViewError: MondayError?
    @Published var seedPhrase: String = "" {
        didSet {
            updateSeedPhraseArray()
        }
    }
    @Published var seedPhraseArray: [String] = []
    @Published var currentScreen: Int = 0

    init(walletClient: Binding<WalletClient>) {
        _walletClient = walletClient
    }

    func saveSeed() async {
        await walletClient.createWallet(
            seedPhrase: seedPhrase,
            network: walletClient.network,
            server: walletClient.server
        )
    }

    private func updateSeedPhraseArray() {
        let trimmedWords = seedPhrase.trimmingCharacters(in: .whitespacesAndNewlines)
        seedPhraseArray = trimmedWords.split(separator: " ").map { String($0) }
    }

    func nextScreen() {
        if currentScreen < 6 {
            currentScreen += 1
        }
    }

    func previousScreen() {
        if currentScreen > 0 {
            currentScreen -= 1
        }
    }
}
