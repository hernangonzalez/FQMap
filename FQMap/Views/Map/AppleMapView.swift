//
//  MapView.swift
//  Visits
//

import UIKit
import SwiftUI
import MapKit

typealias MapRegion = MKCoordinateRegion

struct AppleMapView {
    @Binding var selection: MapAnnotation?
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
        view.register(VenueAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        view.delegate = context.coordinator
        context.coordinator.installGestures(on: view)
        return view
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        assert(view.delegate != nil)
        view.showsUserLocation = viewModel.showsUserLocation
        view.update(annotations: viewModel.annotations)
    }
}

// MARK: - MapRegion
extension MapRegion {
    var maxDistance: CLLocationDistance {
        let lhs = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let rhs = CLLocation(latitude: center.latitude + span.latitudeDelta, longitude: center.longitude + span.longitudeDelta)
        return lhs.distance(from: rhs).rounded()
    }
}

// MARK: - Coordinator
final class AppleMapCoordinator: NSObject {
    private let threshold: CLLocationDistance = 100
    private let view: AppleMapView
    private var lastUserLocation: CLLocation?

    init(with view: AppleMapView) {
        self.view = view
    }
}


// MARK: - MKMapViewDelegate
extension AppleMapCoordinator: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let model = view.annotation as? MapAnnotation {
            self.view.selection = model
        }
        else if let cluster = view.annotation as? MKClusterAnnotation {
            mapView.showAnnotations(cluster.memberAnnotations, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.view.selection = nil
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let update = userLocation.location else {
            return
        }

        let delta = lastUserLocation?.distance(from: update)
        let needsUdapte = delta.map { $0 >= threshold } ?? true
        if needsUdapte {
            view.viewport = mapView.region
        }
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


