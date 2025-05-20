import SwiftUI
import BitcoinUI

struct UnitFormatView: View {
    enum Unit: String, CaseIterable {
        case simplified = "Simplified"
        case satoshi = "Satoshi"
        case original = "Original"
    }

    @State private var selectedUnit: Unit = .simplified

    var nextAction: () -> Void
    var backAction: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 0x46/255, green: 0x50/255, blue: 0x7A/255), location: 0.0),
                    .init(color: Color(red: 0x77/255, green: 0x6D/255, blue: 0x9F/255), location: 0.5),
                    .init(color: Color(red: 0x46/255, green: 0x65/255, blue: 0x8D/255), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

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

                VStack(spacing: 16) {
                    Text("How do you like your bitcoin formatted?")
                        .font(.custom("SFProRounded-Semibold", size: 27))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("It’s the same amount, just shown differently. Choose the style that works for you.")
                        .font(.custom("SFProRounded-Regular", size: 21))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .lineSpacing(4)
                }
                .padding(.bottom, 32)

                ForEach(Unit.allCases, id: \.self) { unit in
                    Button(action: { selectedUnit = unit }) {
                        HStack {
                            Text(leftLabel(for: unit))
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(selectedUnit == unit ? Color(red: 0x46/255, green: 0x50/255, blue: 0x7A/255) : Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(unit.rawValue)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(selectedUnit == unit ? Color(red: 0x46/255, green: 0x50/255, blue: 0x7A/255) : Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.vertical, 18)
                        .padding(.horizontal, 24)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(selectedUnit == unit ? Color.white : Color.white.opacity(0.12))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    }
                    .padding(.bottom, unit != Unit.allCases.last ? 16 : 0) // Add 16 spacing except after the last button
                }
                Spacer()

                Button(action: nextAction) {
                    Text("Next")
                        .font(.custom("SFProRounded-Semibold", size: 21))
                        .foregroundColor(Color(red: 89/255, green: 101/255, blue: 140/255))
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                }
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 16)
        }
    }

    private func leftLabel(for unit: Unit) -> String {
        switch unit {
        case .simplified: return "₿ 1,000"
        case .satoshi: return "Sats 1,000"
        case .original: return "₿ 0.00 001 000"
        }
    }
}

#if DEBUG
struct UnitFormatView_Previews: PreviewProvider {
    static var previews: some View {
        UnitFormatView(nextAction: {}, backAction: {})
    }
}
#endif
