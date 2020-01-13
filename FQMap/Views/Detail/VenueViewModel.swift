//
//  VenueViewModel.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import FQKit

class VenueViewModel: ObservableObject {
    // MARKL Dependencies
    private let provider: VenueProvider

    // MARK: Data
    private var cancellables: CancellableSet = .init()
    private let venueId: String

    // MARK: Presentation
    @Published var title: String = .init()
    @Published var map: AppleMapViewModel = .init()
    @Published var address: String = .init()
    @Published var description: String = .init()
    @Published var photos: [VenuePhotoViewModel] = .init()

    init(provider: VenueProvider = FQKit()) {
        self.venueId = .init()
        self.provider = provider
    }
    
    init(from model: MapAnnotation, provider: VenueProvider = FQKit()) {
        self.venueId = model.venueId
        self.title = model.name
        self.map = AppleMapViewModel(annotations: [model], zoomOnAnnotations: true)
        self.provider = provider
    }

    func updateIfNeeded() {
        let photos = provider.venueDetails(venueId: venueId)
        cancellables += photos
            .catchError(with: .empty)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: updateVenue(_:))
    }
}

private extension VenueViewModel {
    func updateVenue(_ venue: Venue) {
        title = venue.name
        description = venue.description
        address = venue.address
        map = .init(from: [venue], zoom: true)
        photos = venue.photos.compactMap {
            VenuePhotoViewModel(from: $0)
        }
    }
}

// MARK: - Photo
struct VenuePhotoViewModel: Identifiable, Equatable {
    let id: String
    let url: URL
}

extension VenuePhotoViewModel {
    init?(from photo: Photo) {
        guard let url = photo.url else {
            return nil
        }
        self.id = photo.id
        self.url = url
    }
}

private extension Array where Element == Photo {
    var viewModels: [VenuePhotoViewModel] {
        compactMap {
            VenuePhotoViewModel(from: $0)
        }
    }
}
