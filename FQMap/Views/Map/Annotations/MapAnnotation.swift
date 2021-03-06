//
//  MapAnnotation.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import FQKit
import MapKit
import DifferenceKit

class MapAnnotation: MKPointAnnotation {
    let venueId: String
    let name: String

    init(from venue: Venue) {
        venueId = venue.id
        name = venue.name
        super.init()
        coordinate = venue.coordinate
    }

    override init() {
        venueId = .init()
        name = .init()
        super.init()
    }
}

// MARK: - Differentiable
extension MapAnnotation: Differentiable {
    var differenceIdentifier: String {
        venueId
    }
}

// MARK: - Equatable
extension MapAnnotation  {
    static func == (lhs: MapAnnotation, rhs: MapAnnotation) -> Bool {
        return lhs.name == rhs.name
            && lhs.venueId == rhs.venueId
    }
}
