//
//  Codable+Extensions.swift
//  FQKit
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {

    func decode<T: Decodable>(forKey key: Key) throws  -> T {
        return try self.decode(T.self, forKey: key)
    }

    func decodeIfPresent<T: Decodable>(forKey key: Key) throws  -> T? {
        return try self.decodeIfPresent(T.self, forKey: key)
    }

    func decodeArray<T: Decodable>(forKey key: Key) throws  -> [T] {
        return try self.decodeIfPresent([T].self, forKey: key) ?? []
    }
}
