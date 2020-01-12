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
    // MARK: Dependencies
    private let permission: Permission = CLLocationManager()
    private let provider: VenueProvider = FQKit()

    // MARK: Combine
    private var cancellables: CancellableSet = .init()
    private let needsUpdate: PassthroughSubject<Void, Never> = .init()
    var objectWillChange: AnyPublisher<Void, Never> {
        needsUpdate.eraseToAnyPublisher()
    }

    // MARK: Data
    private var error: Error?
    private var venues: [Venue] = .init() {
        willSet { needsUpdate.send() }
    }

    // MARK: Presentation
    var presentDetail: Bool = false {
        willSet { needsUpdate.send() }
    }
    
    var presentError: Bool = false {
        willSet { needsUpdate.send() }
    }

    var errorMessage: String {
        error?.localizedDescription ?? .init()
    }

    var map: AppleMapViewModel {
        .init(from: venues)
    }

    var venueDetail: VenueViewModel {
        let model = selection.map { VenueViewModel(from: $0) }
        return model ?? .init()
    }

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

    func viewDidAppear() {
        permission.enableIfNeeded()
    }
}

private extension ContentViewModel {
    func updateResults() {
        cancellables.cancel()

        let center = searchRegion.center
        let radius = searchRegion.maxDistance
        let places = provider.searchVenues(at: center, radius: radius)

        cancellables += places
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: update(complete:),
                  receiveValue: update(value:))
    }

    func update(complete: Subscribers.Completion<Error>) {
        switch complete {
        case let .failure(value):
            error = value
            presentError = true
        case .finished:
            break
        }
    }

    func update(value: [Venue]) {
        venues = value
    }
}
