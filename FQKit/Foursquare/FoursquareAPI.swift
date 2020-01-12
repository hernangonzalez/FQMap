//
//  Foursquare.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import Alamofire

enum FoursquareAPI {
    case explore(request: ExploreRequest)
    case venueDetails(id: String)
}

// MARK: - URLRequestConvertible
extension FoursquareAPI: URLRequestConvertible {
    // MARK: Constants
    private static let clientId = "PRPRV3AB2HZPLYACCBZXRWHEVTVS3ZRZB4A0D44D3RWHKBEQ"
    private static let secret = "DJ4E3WNYWTVS0W11RLXAS4EFMDPR3E2T0QOWU5NEM3T34DX3"
    private static let apiVersion = "20200101"
    private var baseURL: URL { URL(string: "https://api.foursquare.com/v2/")! }

    private var request: APIRequest {
        switch self {
        case let .explore(request):
            return request
        case let .venueDetails(id):
            return VenueDetailsRequest(venueId: id)
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        // Params
        var params = request.fields
        params["client_id"] = Self.clientId
        params["client_secret"] = Self.secret
        params["v"] = Self.apiVersion

        let encoding = request.encoding
        return try encoding.encode(urlRequest, with: params)
    }
}
