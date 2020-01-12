//
//  Permission.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import CoreLocation

protocol Permission {
    var enabled: Bool { get }
    func enableIfNeeded()
}

extension Permission {
    static var location: Permission { CLLocationManager() }
}

// MARK: - CLLocationManager
extension CLLocationManager: Permission {
    var enabled: Bool {
        CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }

    func enableIfNeeded() {
        requestWhenInUseAuthorization()
    }
}

