//
//  FoursquareResponse.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

struct FoursquareResponse<Value: Decodable>: Decodable {
    struct Meta: Decodable {
        let code: Int
        let requestId: String
    }

    let meta: Meta
    let response: Value
}
