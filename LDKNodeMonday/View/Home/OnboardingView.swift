import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.currentScreen == 0 {
                    CoverScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 1 {
                    BackupInformationScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 2 {
                    ResponsibilityDisclaimerScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 3 {
                    LSPScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 4 {
                    UnitFormatScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 5 {
                    NotificationPermissionScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 6 {
                    FeaturesScreen {
                        viewModel.nextScreen()
                    }
                } else if viewModel.currentScreen == 7 {
                    InitialDepositScreen {
                        viewModel.nextScreen()
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {
                viewModel.previousScreen()
            }) {
                Text("Back")
            })
        }
    }
}

struct CoverScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("Welcome to the Wallet App")
            Button("Create wallet") {
                nextAction()
            }
        }
    }
}

struct BackupInformationScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("Your wallet is being backed up automatically to iCloud.")
            Button("Sounds good") {
                nextAction()
            }
        }
    }
}

struct ResponsibilityDisclaimerScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("You are fully in control of your bitcoin.")
            Button("I understand") {
                nextAction()
            }
        }
    }
}

struct LSPScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("The application will rely on an LSP (Lightning Service Provider) for connecting to the lightning network.")
            Button("Great") {
                nextAction()
            }
        }
    }
}

struct UnitFormatScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("Choose your unit format:")
            Button("Bitcoin") {
                nextAction()
            }
            Button("Satoshi") {
                nextAction()
            }
            Button("Simplified") {
                nextAction()
            }
        }
    }
}

struct NotificationPermissionScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("Enable notifications to be informed of new payments.")
            Button("Next") {
                // Trigger OS-notification request here
                nextAction()
            }
        }
    }
}

struct FeaturesScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("There are plenty of other features in the application. You will get to know them through your interactions.")
            Button("Let's go") {
                nextAction()
            }
        }
    }
}

struct InitialDepositScreen: View {
    var nextAction: () -> Void

    var body: some View {
        VStack {
            Text("Make an initial deposit to have funds in your wallet.")
            // QR code of the first bitcoin address should be displayed here
            Button("Share") {
                // Activate the native share sheet for sharing the bitcoin address as a BIP21 URI
            }
            Button("Do this later") {
                nextAction()
            }
        }
    }
}
