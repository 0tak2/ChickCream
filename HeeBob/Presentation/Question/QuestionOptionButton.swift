//
//  QuestionOptionButton.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct QuestionOptionButton: View {
    let title: String
    let isDisabled: Bool
    let didTap: () -> Void
    
    private var baseFillColor: Color {
        isDisabled ? .clear : .hbPrimaryLighten
    }
    
    private var baseStrokeColor: Color {
        isDisabled ? .hbDisabled : .hbPrimary
    }

    var body: some View {
        Button(action: didTap) {
            Text(title)
                .font(.hbSubtitle)
                .foregroundStyle(isDisabled ? Color.hbDisabled : Color.hbPrimary)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .buttonStyle(
            QuestionOptionButtonStyle(
                fillColor: baseFillColor,
                strokeColor: baseStrokeColor
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct QuestionOptionButtonStyle: ButtonStyle {
    let fillColor: Color
    let strokeColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
            .contentShape(Rectangle()) // 터치 영역
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isPressed ? Color.hbPrimary : fillColor)
                    .stroke(strokeColor, lineWidth: 3)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
    }
}
