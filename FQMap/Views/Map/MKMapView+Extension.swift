//
//  MKMapView+Extension.swift
//  Visits
//

import MapKit
import DifferenceKit

// MARK: - Update
extension MKMapView {

    @discardableResult
    func update(annotations rhs: [MapAnnotation]) -> Bool {
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

        return changeset.contains {
            !$0.elementInserted.isEmpty || !$0.elementDeleted.isEmpty
        }
    }
}

// MARK: - Annotations
extension MKAnnotationView {
    static var identifier: String {
        return String(describing: self)
    }

    convenience init(annotation: MKAnnotation) {
        self.init(annotation: annotation,
                  reuseIdentifier: type(of: self).identifier)
    }
}

extension MKMapView {

    func loadAnnotation<View: MKAnnotationView>(with annotation: MKAnnotation) -> View? {
        return dequeueReusableAnnotationView(withIdentifier: View.identifier) as? View
    }

    func register<View: MKAnnotationView>(_ type: View.Type) {
        register(type, forAnnotationViewWithReuseIdentifier: View.identifier)
    }
}
