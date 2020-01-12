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
    public init() { }
}

public extension FQKit {

    /// Search venues around a point.
    func searchVenues(at coordiante: Coordiante2D, radius: Double) -> AnyPublisher<[Venue], Error> {
        let radius = min(radius, 100_000)
        let request = ExploreRequest(coordiante: coordiante, radius: radius)
        let api = FoursquareAPI.explore(request: request)
        let response = Network.response(from: api) as AnyPublisher<FoursquareResponse<ExploreResponse>, Error>
        return response
            .map { $0.response.items }
            .eraseToAnyPublisher()
    }

    func venueDetails(venueId: String)  -> AnyPublisher<Venue, Error> {
        let api = FoursquareAPI.venueDetails(id: venueId)
        let response = Network.response(from: api) as AnyPublisher<FoursquareResponse<VenueDetailsResponse>, Error>
        return response
            .map { $0.response }
            .map { Venue(from: $0) }
            .eraseToAnyPublisher()
    }
}
