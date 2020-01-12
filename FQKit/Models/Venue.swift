//
//  Venue.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

public struct Venue {
    public let id: String
    public let name: String
    public let coordinate: Coordiante2D
    public let address: String
    public let description: String
    public let photos: [Photo]
}

// MARK: - Photo
public struct Photo: Decodable {
    public let id: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
}

public extension Photo {
    var url: URL? {
        URL(string: prefix).map {
            $0.appendingPathComponent("\(width)x\(height)").appendingPathComponent(suffix)
        }
    }
}

// MARK: - Location
struct Location: Decodable {
    let lat: Double
    let lng: Double
    let address: String?

    var coordinate: Coordiante2D {
        .init(latitude: lat, longitude: lng)
    }
}

