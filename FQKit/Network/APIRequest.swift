//
//  APIRequest.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import Alamofire

typealias Parameters = Alamofire.Parameters

protocol APIRequest {
    var fields: Parameters { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension APIRequest {
    var method: HTTPMethod { .get }
    var encoding: ParameterEncoding { URLEncoding.default }
}

protocol JSONEncodable: Encodable {
    typealias Target = Self
}

enum JSONError: Swift.Error {
    case decoding
}

extension JSONEncodable {

    func encoded() -> Parameters {
        do {
            let encoder = JSONEncoder()
            let typed: Target = self
            let jsonData = try encoder.encode(typed)
            guard let data = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Parameters else {
                throw JSONError.decoding
            }
            return data
        } catch {
            fatalError("Encoding failed.")
        }
    }
}
