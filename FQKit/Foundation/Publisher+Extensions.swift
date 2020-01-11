//
//  Publisher+Extensions.swift
//  Visits
//
//  Created by Hernan G. Gonzalez on 24/09/2019.
//  Copyright © 2019 Indeba. All rights reserved.
//

import Foundation
import Combine

public extension Publisher {

    static var empty: AnyPublisher<Output, Failure> {
        Empty().eraseToAnyPublisher()
    }

    func catchError(with other: AnyPublisher<Output, Never>) -> AnyPublisher<Output, Never> {
        return self.catch { error -> AnyPublisher<Output, Never> in
            return other
        }.eraseToAnyPublisher()
    }
}
