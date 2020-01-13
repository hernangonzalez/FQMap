//
//  ActionStyleModifier.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 13/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import SwiftUI

struct ActionStyleModifier<S: Shape>: ViewModifier {
    let shape: S
    let active: Bool

    private var strokeColor: Color { active ? .white : .gray }

    private var borderOverlay: some View {
        shape.stroke(strokeColor, lineWidth: 1.5)
    }

    func body(content: Content) -> some View {
        content
            .foregroundColor(.primary)
            .background(Color(.tertiarySystemBackground))
            .clipShape(shape)
            .overlay(borderOverlay)
            .shadow(radius: 4, x: 2, y: 2)
    }
}

extension View {
    func applyActionStyle<S: Shape>(_ shape: S, _ active: Bool) -> some View {
        modifier(ActionStyleModifier(shape: shape, active: active))
    }
}
