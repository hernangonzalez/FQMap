//
//  FQKit.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//
import Combine

public class FQKit {
    public static let version = 1
}

public extension FQKit {

    /// Search venues around a point.
    static func searchVenues(at coordiante: Coordiante2D, radius: Double) -> AnyPublisher<[Venue], Error> {
        let request = ExploreRequest(coordiante: coordiante, radius: radius)
        let api = FoursquareAPI.explore(request: request)
        let response = Network.response(from: api) as AnyPublisher<FoursquareResponse<ExploreResponse>, Error>
        return response.map {
            $0.response.venues
        }.eraseToAnyPublisher()
    }
}
