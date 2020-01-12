//
//  VenueViewModel.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import FQKit

struct VenueViewModel {
    let title: String
}

extension VenueViewModel {
    init() {
        title = .init()
    }
    
    init(from venue: Venue) {
        title = venue.name
    }
}
