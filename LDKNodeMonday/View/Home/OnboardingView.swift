import SwiftUI

enum OnboardingStep: CaseIterable {
    case cover, backup, disclaimer, lsp, unit, notification, features, deposit
}

// Add enums for sub-flows
enum BackupSubStep {
    case info, details
}
enum LSPSubStep {
    case main, options, details
}

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var currentStepIndex = 0
    @State private var isForward = true

    // Sub-flow state
    @State private var backupSubStep: BackupSubStep = .info
    @State private var lspSubStep: LSPSubStep = .main

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
                withAnimation {
                    currentStepIndex += 1
                    // Reset sub-flows when advancing to a new main step
                    backupSubStep = .info
                    lspSubStep = .main
                }
            }
        }
        let onBack = {
            if currentStepIndex > 0 {
                isForward = false
                withAnimation {
                    currentStepIndex -= 1
                    // Reset sub-flows when going back to a previous main step
                    backupSubStep = .info
                    lspSubStep = .main
                }
            }
        }
        switch OnboardingStep.allCases[currentStepIndex] {
        case .cover:
            CoverScreen(nextAction: onNext, backAction: onBack, viewModel: viewModel)
        case .backup:
            switch backupSubStep {
            case .info:
                BackupInformationView(
                    nextAction: onNext,
                    backAction: onBack,
                    showDetailsAction: {
                        isForward = true
                        withAnimation {
                            backupSubStep = .details
                        }
                    }
                )
            case .details:
                BackupDetailsView(
                    nextAction: {
                        isForward = true
                        withAnimation {
                            backupSubStep = .info
                            onNext()
                        }
                    },
                    backAction: {
                        isForward = false
                        withAnimation {
                            backupSubStep = .info
                        }
                    }
                )
            }
        case .disclaimer:
            ResponsibilityDisclaimerView(nextAction: onNext, backAction: onBack)
        case .lsp:
            switch lspSubStep {
            case .main:
                LSPView(
                    nextAction: onNext,
                    backAction: onBack,
                    showOptionsAction: {
                        isForward = true
                        withAnimation {
                            lspSubStep = .options
                        }
                    }
                )
            case .options:
                LSPOptionsView(
                    nextAction: {
                        isForward = true
                        withAnimation {
                            lspSubStep = .details
                        }
                    },
                    backAction: {
                        isForward = false
                        withAnimation {
                            lspSubStep = .main
                        }
                    }
                )
            case .details:
                LSPDetailsView(
                    nextAction: { withAnimation { lspSubStep = .main; onNext() } },
                    backAction: { withAnimation { lspSubStep = .options } }
                )
            }
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