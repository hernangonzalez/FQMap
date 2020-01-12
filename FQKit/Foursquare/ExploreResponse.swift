//
//  ExploreResponse.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

struct ExploreVenue: Decodable {
    let id: String
    let name: String
    let location: Location
}

struct ExploreResponse: Decodable {
    private let venues: [ExploreVenue]
}

extension ExploreResponse {
    var items: [Venue] {
        venues.map { Venue(from: $0) }
    }
}

// MARK: - Venue
extension Venue {
    init(from other: ExploreVenue) {
        id = other.id
        name = other.name
        coordinate = other.location.coordinate
        address = .init()
        description = .init()
        photos = []
    }
}
