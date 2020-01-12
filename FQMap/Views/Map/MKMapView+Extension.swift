//
//  MKMapView+Extension.swift
//  Visits
//

import MapKit
import DifferenceKit

// MARK: - Update
extension MKMapView {

    func update(annotations rhs: [MapAnnotation]) {
        let lhs = annotations.compactMap { $0 as? MapAnnotation }

        let changeset = StagedChangeset(source: lhs, target: rhs)
        changeset.forEach { change in
            let removed = change.elementDeleted.map {
                lhs[$0.element]
            }
            removeAnnotations(removed)

            let inserted = change.elementInserted.map {
                rhs[$0.element]
            }
            addAnnotations(inserted)
        }
    }
}
