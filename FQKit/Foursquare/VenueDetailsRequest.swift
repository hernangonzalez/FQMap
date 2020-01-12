//
//  VenuePhotoRequest.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

struct VenueDetailsRequest: APIRequest {
    let venueId: String
    let fields: Parameters = .init()
    var path: String { "venues/\(venueId)" }
}
