//
//  CircleButton.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 13/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import SwiftUI
import SFSymbol

struct CircleButton: View {
    let symbol: SFSymbol
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol.rawValue)
                .frame(width: 48, height: 48)
                .aspectRatio(contentMode: .fit)
                .applyActionStyle(Circle(), false)
        }
    }
}
