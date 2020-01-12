//
//  VenuePhotoResponse.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

struct VenueDetailsResponse {
    let id: String
    let name: String
    let description: String
    let location: Location
    let photos: [Photo]
}

// MARK: - Decodable
extension VenueDetailsResponse: Decodable {
    struct Photos: Decodable {
        let items: [Photo]
    }

    struct PhotoGroups: Decodable {
        let groups: [Photos]
    }

    enum CodingKeys: String, CodingKey {
        case photos, id, name, location, description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photoGroups = try container.decode(PhotoGroups.self, forKey: .photos)
        photos = photoGroups.groups.flatMap { $0.items }
        id = try container.decode(forKey: .id)
        name = try container.decode(forKey: .name)
        location = try container.decode(forKey: .location)
        description = try container.decodeIfPresent(forKey: .description) ?? .init()
    }
}

// MARK: - Venue
extension Venue {
    init(from other: VenueDetailsResponse) {
        id = other.id
        name = other.name
        coordinate = other.location.coordinate
        address = other.location.address ?? .init()
        description = other.description
        photos = other.photos
    }
}
