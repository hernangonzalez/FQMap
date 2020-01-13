//
//  Seeds.swift
//  FQMapTests
//
//  Created by Hernan G. Gonzalez on 13/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
@testable import FQKit

enum Seeds {
    static let photo: Photo = .init(id: "1",
                                    prefix: "prefix_",
                                    suffix: "_suffix",
                                    width: 200,
                                    height: 200)

    static let venue: Venue = .init(id: "0",
                                    name: "A Restaurant",
                                    coordinate: .init(latitude: 10, longitude: 10),
                                    address: "A new address",
                                    description: "Looks nice",
                                    photos: [])
}
