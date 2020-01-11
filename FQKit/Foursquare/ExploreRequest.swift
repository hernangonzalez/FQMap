//
//  ExploreRequest.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import CoreLocation

public typealias Coordiante2D = CLLocationCoordinate2D

enum Intent: String, Encodable {
    case browse
}

struct ExploreRequest {
    let coordiante: Coordiante2D
    let intent: Intent = .browse
    let radius: Double
}

extension ExploreRequest: JSONEncodable {
    enum CodingKeys: String, CodingKey {
        case ll, radius, intent
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let ll = [coordiante.latitude, coordiante.longitude]
            .map { $0.description }
            .joined(separator: ",")
        try container.encode(ll, forKey: .ll)
        try container.encode(radius, forKey: .radius)
        try container.encode(intent, forKey: .intent)
    }
}

// MARK: - APIRequest
extension ExploreRequest: APIRequest {
    var fields: Parameters { encoded() }
    var path: String { "venues/search" }
}
