//
//  AppleMapViewModel.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import DifferenceKit
import FQKit

struct AppleMapViewModel {
    let annotations: [MapAnnotation]
}

extension AppleMapViewModel {
    init() {
         annotations = .init()
     }

    init(from venues: [Venue]) {
        annotations = venues.map {
            MapAnnotation(from: $0)
        }
    }
}
