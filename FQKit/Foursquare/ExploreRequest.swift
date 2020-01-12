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

enum Categories: String, Encodable {
    case food = "4d4b7105d754a06374d81259"
}

struct ExploreRequest {
    let coordiante: Coordiante2D
    let radius: Double
    let intent: Intent = .browse
    let categories: [Categories] = [.food]
}

extension ExploreRequest: JSONEncodable {
    enum CodingKeys: String, CodingKey {
        case ll, radius, intent, categoryId
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let ll = [coordiante.latitude, coordiante.longitude]
            .map { $0.description }
            .joined(separator: ",")
        let categoryList = categories
            .map { $0.rawValue }
            .joined(separator: ",")

        try container.encode(ll, forKey: .ll)
        try container.encode(radius, forKey: .radius)
        try container.encode(intent, forKey: .intent)
        try container.encode(categoryList, forKey: .categoryId)
    }
}

// MARK: - APIRequest
extension ExploreRequest: APIRequest {
    var fields: Parameters { encoded() }
    var path: String { "venues/search" }
}
