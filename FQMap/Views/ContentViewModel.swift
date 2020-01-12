//
//  ContentViewModel.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import FQKit
import CoreLocation

class ContentViewModel: ObservableObject {
    private var cancellables: CancellableSet = .init()
    private var venues: CurrentValueSubject<[Venue], Never> = .init([])
    private let permission: Permission = CLLocationManager()
    private let provider: VenueProvider = FQKit()

    @Published var map: AppleMapViewModel = .init()
    @Published var presentDetail: Bool = false

    var searchRegion: MapRegion = .init() {
        didSet {
            updateResults()
        }
    }

    var selection: MapAnnotation? = nil {
        didSet {
            cancellables.cancel()
            presentDetail = selection != nil
        }
    }

    func venueDetail() -> VenueViewModel {
        let model = selectedVenue.map {
            VenueViewModel(from: $0)
        }
        return model ?? .init()
    }
}

private extension ContentViewModel {
    func updateResults() {
        cancellables.cancel()

        let center = searchRegion.center
        let radius = max(searchRegion.span.latitudeDelta, searchRegion.span.longitudeDelta)
        let places = provider.searchVenues(at: center, radius: radius)
            .share()
            .print()

        cancellables += places
            .catchError(with: .empty)
            .assign(to: \.venues.value, on: self)

        cancellables += places
            .catchError(with: .empty)
            .map { AppleMapViewModel(from: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.map, on: self)
    }

    var selectedVenue: Venue? {
        selection.flatMap {
            venues.value.first(with: $0.venueId)
        }
    }
}
