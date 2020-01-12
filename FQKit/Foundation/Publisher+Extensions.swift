//
//  Publisher+Extensions.swift
//  Visits
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

public typealias CancellableSet = Array<AnyCancellable>

public extension CancellableSet {
    static func += (lhs: inout Array<Element>, rhs: Element) {
        lhs.append(rhs)
    }
}

public extension CancellableSet {
    func cancel() {
        forEach { $0.cancel() }
    }
}
