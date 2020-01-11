//
//  URLRequest+Combine.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 11/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import Combine
import Alamofire

enum Network {
    typealias Endpoint = URLRequestConvertible
    static let queue: DispatchQueue = .init(label: "queue.network")
}

// MARK: - Public
extension Network {

    static func response<Value: Decodable>(from endpoint: Endpoint) -> AnyPublisher<Value, Error> {
        let response = data(from: endpoint)
        return response.tryMap {
            let decoder = JSONDecoder()
            return try decoder.decode(Value.self, from: $0)
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Private
private extension Network {

    static func data(from request: URLRequestConvertible) -> AnyPublisher<Data, Error> {
        Future { promise in
            let request = Alamofire.request(request)
            request.responseData { response in
                switch response.result {
                case let .success(value):
                    promise(.success(value))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .subscribe(on: queue)
        .eraseToAnyPublisher()
    }
}
