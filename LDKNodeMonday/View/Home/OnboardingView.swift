import SwiftUI

enum OnboardingStep: CaseIterable {
    case cover, backup, disclaimer, lsp, unit, notification, features, deposit
}

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var currentStepIndex = 0
    @State private var isForward = true

    var body: some View {
        ZStack {
            currentScreenView()
                .id(currentStepIndex) // Ensures transition triggers
                .transition(
                    .asymmetric(
                        insertion: .move(edge: isForward ? .trailing : .leading),
                        removal: .move(edge: isForward ? .leading : .trailing)
                    )
                )
                .animation(.easeInOut, value: currentStepIndex)
        }
    }

    @ViewBuilder
    private func currentScreenView() -> some View {
        let onNext = {
            if currentStepIndex < OnboardingStep.allCases.count - 1 {
                isForward = true
                withAnimation { currentStepIndex += 1 }
            }
        }
        let onBack = {
            if currentStepIndex > 0 {
                isForward = false
                withAnimation { currentStepIndex -= 1 }
            }
        }
        switch OnboardingStep.allCases[currentStepIndex] {
        case .cover:
            CoverScreen(nextAction: onNext, backAction: onBack, viewModel: viewModel)
        case .backup:
            BackupInformationView(nextAction: onNext, backAction: onBack)
        case .disclaimer:
            ResponsibilityDisclaimerView(nextAction: onNext, backAction: onBack)
        case .lsp:
            LSPView(nextAction: onNext, backAction: onBack)
        case .unit:
            UnitFormatView(nextAction: onNext, backAction: onBack)
        case .notification:
            NotificationPermissionView(nextAction: onNext, backAction: onBack)
        case .features:
            FeaturesView(nextAction: onNext, backAction: onBack)
        case .deposit:
            InitialDepositView(nextAction: {/* handle finish */}, backAction: onBack, viewModel: viewModel)
        }
    }
}