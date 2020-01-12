//
//  Venue.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

public struct Venue: Decodable {
    public let id: String
    public let name: String
    public let location: Location
}

public extension Venue {
    struct Location: Decodable {
        let lat: Double
        let lng: Double

        public var coordinate: Coordiante2D {
            .init(latitude: lat, longitude: lng)
        }
    }
}

public extension Array where Element == Venue {
    func first(with id: String) -> Venue? {
        first { $0.id == id}
    }
}
