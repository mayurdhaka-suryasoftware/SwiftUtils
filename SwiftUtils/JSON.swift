//
//  JSON.swift
//  TimeTracker
//
//  Created by Gopal Sharma on 8/23/16.
//  Copyright © 2016 Surya Software Systems Pvt. Ltd. All rights reserved.
//

import Foundation


public enum JSONError: Error {
    case missingValue(String)
    case invalidValue(String)
    case invalidJSON(Error?)
    case unknown(String?)
}

public protocol JSONInitializable {
    init(json: JSON) throws
}

public class JSON {

    private let json: [String: Any]

    public init(json: [String: Any]) {
        self.json = json
    }

    public convenience init(string: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw JSONError.unknown("Unable to convert string to Data")
        }
        try self.init(data: data)
    }

    public convenience init(data: Data) throws {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                throw JSONError.invalidJSON(JSONError.unknown("Root object is not a [String: Any]"))
            }
            self.init(json: json)
        } catch let error {
            throw JSONError.invalidJSON(error)
        }
    }

    public func value<T>(forKey key: String, type: T.Type) throws -> T {
        guard let _ = json[key] else {
            throw JSONError.missingValue(key)
        }
        guard let value = json[key] as? T else {
            throw JSONError.invalidValue(key)
        }
        return value
    }

    public func value<T>(forKey key: String, defaultValue: T, type: T.Type) -> T {
        do {
            return try value(forKey: key, type: type)
        } catch {
            return defaultValue
        }
    }

    public func UUID(forKey key: String) throws -> UUID {
        let stringValue = try value(forKey: key, type: String.self)
        guard let uuid = Foundation.UUID.init(uuidString: stringValue) else {
            throw JSONError.invalidValue("\(key) = \(stringValue)")
        }
        return uuid
    }

    public func string(forKey key: String) throws -> String {
        return try value(forKey: key, type: String.self)
    }

    public func string(forKey key: String, defaultValue: String) -> String {
        return value(forKey: key, defaultValue: defaultValue, type: String.self)
    }

    public func int(forKey key: String) throws -> Int {
        return try value(forKey: key, type: Int.self)
    }

    public func int(forKey key: String, defaultValue: Int) -> Int {
        return value(forKey: key, defaultValue: defaultValue, type: Int.self)
    }

    public func bool(forKey key: String) throws -> Bool {
        return try value(forKey: key, type: Bool.self)
    }

    public func bool(forKey key: String, defaultValue: Bool) -> Bool {
        return value(forKey: key, defaultValue: defaultValue, type: Bool.self)
    }

    public func json(forKey key: String) throws -> JSON {
        return JSON.init(json: try value(forKey: key, type: [String: Any].self))
    }

    public func array(forKey key: String) throws -> NSArray {
        return try value(forKey: key, type: NSArray.self)
    }

    public func array<T>(forKey key: String, ofType: T.Type) throws -> [T] where T: JSONInitializable {
        let itemsJSON = try array(forKey: key)
        var items: [T] = []
        for (index, itemJSON) in itemsJSON.enumerated() {
            guard let json = itemJSON as? [String: Any] else {
                throw JSONError.invalidJSON(JSONError.unknown("Item at \(index) is not a [String: Any]"))
            }
            let item = try T.init(json: JSON.init(json: json))
            items.append(item)
        }
        return items
    }

    public func hasKey(_ key: String) -> Bool {
        if let _ = json[key] {
            return true
        }
        return false
    }

    public func hasKey<T>(_ key: String, ofType: T.Type) -> Bool {
        if let _ = json[key] as? T {
            return true
        }
        return false
    }

}
