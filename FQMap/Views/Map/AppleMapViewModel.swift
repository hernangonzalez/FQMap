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
    let showsUserLocation: Bool = true
    let zoomOnAnnotations: Bool
}

extension AppleMapViewModel {
    init() {
        annotations = .init()
        zoomOnAnnotations = false
     }

    init(from venues: [Venue], zoom: Bool) {
        zoomOnAnnotations = zoom
        annotations = venues.map {
            MapAnnotation(from: $0)
        }
    }
}
