//
//  VenueProvider.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import Combine
import FQKit

protocol VenueProvider {
    func searchVenues(at coordiante: Coordiante2D, radius: Double) -> AnyPublisher<[Venue], Error>
}

extension FQKit: VenueProvider {
}
