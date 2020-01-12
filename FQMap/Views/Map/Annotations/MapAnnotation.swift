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

    init(from venue: Venue) {
        venueId = venue.id
        super.init()
        coordinate = venue.location.coordinate
        title = venue.name
    }
}

extension MapAnnotation: Differentiable {
    var differenceIdentifier: String {
        venueId
    }
}

