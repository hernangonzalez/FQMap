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
    private let provider: VenueProvider = FQKit()

    // MARK: Data
    private var cancellables: CancellableSet = .init()
    private let venueId: String

    // MARK: Presentation
    @Published var title: String = .init()
    @Published var map: AppleMapViewModel = .init()
    @Published var address: String = .init()
    @Published var description: String = .init()
    @Published var photos: [VenuePhotoViewModel] = .init()

    init() {
        venueId = .init()
    }
    
    init(from model: MapAnnotation) {
        venueId = model.venueId
        title = model.name
        map = AppleMapViewModel(annotations: [model], zoomOnAnnotations: true)
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
        map = .init(from: [venue], zoom: true)
        photos = venue.photos.compactMap {
            VenuePhotoViewModel(from: $0)
        }
    }
}

// MARK: - Photo
struct VenuePhotoViewModel: Identifiable {
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
