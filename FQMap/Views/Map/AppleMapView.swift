//
//  MapView.swift
//  Visits
//
//  Created by Hernan G. Gonzalez on 10/10/2019.
//  Copyright © 2019 Indeba. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit

typealias MapRegion = MKCoordinateRegion

struct AppleMapView {
    @Binding var viewport: MapRegion
    let viewModel: AppleMapViewModel
}

// MARK: - UIViewRepresentable
extension AppleMapView: UIViewRepresentable {

    func makeCoordinator() -> AppleMapCoordinator {
        AppleMapCoordinator(with: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        view.showsUserLocation = true
        context.coordinator.installGestures(on: view)
        return view
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        assert(view.delegate != nil)
        view.update(annotations: viewModel.annotations)
    }
}

// MARK: - Coordinator
final class AppleMapCoordinator: NSObject {
    private let view: AppleMapView

    init(with view: AppleMapView) {
        self.view = view
    }
}

// MARK: - MKMapViewDelegate
extension AppleMapCoordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}

// MARK: - Gestures
fileprivate extension AppleMapCoordinator {
    func installGestures(on view: UIView) {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureDidUpdate(in:)))
        let pinGesture = UIPinchGestureRecognizer(target: self, action: #selector(gestureDidUpdate(in:)))
        let zoomGesture = UITapGestureRecognizer(target: self, action: #selector(gestureDidUpdate(in:)))
        zoomGesture.numberOfTapsRequired = 2
        [dragGesture, pinGesture, zoomGesture].forEach {
            $0.delegate = self
            view.addGestureRecognizer($0)
        }
    }

    @objc
    private func gestureDidUpdate(in recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .ended, let map = recognizer.view as? MKMapView else {
            return
        }
        view.viewport = map.region
    }
}


// MARK: - UIGestureRecognizerDelegate
extension AppleMapCoordinator: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


