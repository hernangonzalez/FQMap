//
//  FQMapTests.swift
//  FQMapTests
//
//  Created by Hernan G. Gonzalez on 13/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Quick
import Nimble
import Combine
@testable import FQKit
@testable import FQMap

class VenueViewModelTests: QuickSpec {

    override func spec() {

        let provider = VenueProviderSpy()
        var subject: VenueViewModel!

        describe("VenueViewModel") {
            describe("init") {
                context("Default") {
                    // Given

                    // When
                    beforeEach {
                        subject = .init(provider: provider)
                    }

                    // Then
                    it("title is empty") {
                        expect(subject.title).to(beEmpty())
                    }

                    it("photo is empty") {
                        expect(subject.photos).to(beEmpty())
                    }

                    it("map is empty") {
                        expect(subject.map.annotations).to(beEmpty())
                    }

                    it("address is empty") {
                        expect(subject.address).to(beEmpty())
                    }

                    it("description is empty") {
                        expect(subject.description).to(beEmpty())
                    }
                }

                context("annotation") {
                    // Given
                    let venue = Seeds.venue
                    let annotation = MapAnnotation(from: venue)

                    // When
                    beforeEach {
                        subject = .init(from: annotation, provider: provider)
                    }

                    // Then
                    it("title matches venue") {
                        expect(subject.title).to(equal(venue.name))
                    }

                    it("photo is empty") {
                        expect(subject.photos).to(beEmpty())
                    }

                    it("map contains the annotation") {
                        expect(subject.map.annotations).to(contain(annotation))
                    }

                    it("map zoom is enabled") {
                        expect(subject.map.zoomOnAnnotations).to(beTrue())
                    }

                    it("address is empty") {
                        expect(subject.address).to(beEmpty())
                    }

                    it("description is empty") {
                        expect(subject.description).to(beEmpty())
                    }
                }
            }

            describe("updateIfNeeded") {
                // Given
                let venue = Seeds.venue
                let annotation = MapAnnotation(from: venue)

                // When
                beforeEach {
                    subject = .init(from: annotation, provider: provider)
                    subject.updateIfNeeded()
                }

                // Then
                it("title matches venue") {
                    expect(subject.title).toEventually(equal(venue.name))
                }

                it("photo is empty") {
                    let result: [VenuePhotoViewModel] = Seeds.venue.photos.compactMap { VenuePhotoViewModel(from: $0) }
                    expect(subject.photos).toEventually(equal(result))
                }

                it("map contains the annotation") {
                    expect(subject.map.annotations.first?.venueId).toEventually(equal(annotation.venueId))
                }

                it("map zoom is enabled") {
                    expect(subject.map.zoomOnAnnotations).toEventually(beTrue())
                }

                it("address is empty") {
                    expect(subject.address).toEventually(equal(venue.address))
                }

                it("description matches venue") {
                    expect(subject.description).toEventually(equal(venue.description))
                }
            }
        }
    }
}

// MARK: - Support
struct VenueProviderSpy: VenueProvider {
    func searchVenues(at coordiante: Coordiante2D, radius: Double) -> AnyPublisher<[Venue], Error> {
        .empty
    }

    func venueDetails(venueId: String) -> AnyPublisher<Venue, Error> {
        .just(Seeds.venue)
    }
}
