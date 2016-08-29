//
//  JSON.swift
//  TimeTracker
//
//  Created by Gopal Sharma on 8/23/16.
//  Copyright © 2016 Surya Software Systems Pvt. Ltd. All rights reserved.
//

import Foundation


public enum JSONError: ErrorType {
    case MissingValue(String)
    case InvalidValue(String)
    case Unknown
}

public protocol JSONInitializable {
    init(json: JSON) throws
}

public class JSON {

    private let json: AnyObject

    public init(json: AnyObject) {
        self.json = json
    }

    public func valueForKey<T>(key: String, type: T.Type) throws -> T {
        guard let _ = json.valueForKey(key) else {
            throw JSONError.MissingValue(key)
        }
        guard let value = json.valueForKey(key) as? T else {
            throw JSONError.InvalidValue(key)
        }
        return value
    }

    public func valueForKey<T>(key: String, defaultValue: T, type: T.Type) -> T {
        do {
            return try valueForKey(key, type: type)
        } catch {
            return defaultValue
        }
    }

    public func UUIDForKey(key: String) throws -> NSUUID {
        let stringValue = try valueForKey(key, type: String.self)
        guard let uuid = NSUUID.init(UUIDString: stringValue) else {
            throw JSONError.InvalidValue("\(key) = \(stringValue)")
        }
        return uuid
    }

    public func stringForKey(key: String) throws -> String {
        return try valueForKey(key, type: String.self)
    }

    public func stringForKey(key: String, defaultValue: String) -> String {
        return valueForKey(key, defaultValue: defaultValue, type: String.self)
    }

    public func intForKey(key: String) throws -> Int {
        return try valueForKey(key, type: Int.self)
    }

    public func intForKey(key: String, defaultValue: Int) -> Int {
        return valueForKey(key, defaultValue: defaultValue, type: Int.self)
    }

    public func boolForKey(key: String) throws -> Bool {
        return try valueForKey(key, type: Bool.self)
    }

    public func boolForKey(key: String, defaultValue: Bool) -> Bool {
        return valueForKey(key, defaultValue: defaultValue, type: Bool.self)
    }

    public func jsonForKey(key: String) throws -> JSON {
        return JSON.init(json: try valueForKey(key, type: AnyObject.self))
    }

    public func arrayForKey(key: String) throws -> NSArray {
        return try valueForKey(key, type: NSArray.self)
    }

    public func arrayForKey<T where T: JSONInitializable>(key: String, ofType: T.Type) throws -> [T] {
        let itemsJSON = try arrayForKey(key)
        var items: [T] = []
        for itemJSON in itemsJSON {
            let item = try T.init(json: JSON.init(json: itemJSON))
            items.append(item)
        }
        return items
    }

    public func hasKey(key: String) -> Bool {
        if let _ = json.valueForKey(key) {
            return true
        }
        return false
    }

    public func hasKey<T>(key: String, ofType: T.Type) -> Bool {
        if let _ = json.valueForKey(key) as? T {
            return true
        }
        return false
    }

}
