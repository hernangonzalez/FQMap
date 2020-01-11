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

class ContentViewModel: ObservableObject {
    @Published var map: AppleMapViewModel = .init()
    private var cancellable: AnyCancellable?

    var searchRegion: MapRegion = .init() {
        didSet {
            updateResults()
        }
    }
}

private extension ContentViewModel {
    func updateResults() {
        let center = searchRegion.center
        let radius = max(searchRegion.span.latitudeDelta, searchRegion.span.longitudeDelta)
        let places = FQKit.searchVenues(at: center, radius: radius)
        cancellable = places
            .catchError(with: .empty)
            .map { AppleMapViewModel(from: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.map, on: self)
    }
}
