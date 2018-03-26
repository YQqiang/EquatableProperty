//
//  EquatableProperty.swift
//  EquatableProperty
//
//  Created by sungrow on 2018/3/24.
//  Copyright © 2018年 sungrow. All rights reserved.
//

import Foundation

infix operator =*=: EqualProperty
precedencegroup EqualProperty {
    associativity: left
    higherThan: MultiplicationPrecedence
}

protocol EquatableProperty: EquatableAny {
}

extension EquatableProperty {
    static func =*=(_ a: Self, b: Self) -> Bool {
        return equalProperty(a, b: b)
    }
}

extension EquatableProperty {
    private static func equalProperty<T>(_ a: T, b: T) -> Bool {
        let aMirro = Mirror(reflecting: a)
        let bMirro = Mirror(reflecting: b)
        var result = true
        for aChild in aMirro.children {
            for bChild in bMirro.children {
                let (aKey, aValue) = (aChild.label, aChild.value)
                let (bKey, bValue) = (bChild.label, bChild.value)
                if aKey == bKey {
                    let a = type(of: aValue)
                    debugPrint("typeOf: \(a)")
                    if aValue is EquatableProperty {
                        if bValue is EquatableProperty {
                            result = equalProperty(aValue, b: bValue)
                        }
                    }
                    if let res = equalSet(aValue: aValue, bValue: bValue) {
                        result = result && res
                    }
                    if let res = equalAny(aValue: aValue, bValue: bValue) {
                        result = result && res
                    }
                    if  !result {
                        return result
                    }
                }
            }
        }
        return result
    }
}

protocol EquatableAny {
    static func equalAny<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool?
    static func equalAny(aValue: Any, bValue: Any) -> Bool?
    static func equalSet(aValue: Any, bValue: Any) -> Bool?
}

extension EquatableAny {
    static func equalAny<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        if (a as? T) != nil && (b as? T) == nil {
            return false
        }
        if (b as? T) != nil && (a as? T) == nil {
            return false
        }
        guard let a = a as? T, let b = b as? T else { return nil }
        return a == b
    }
    
    static func equalAny(aValue: Any, bValue: Any) -> Bool? {
        if let res = equalAny(type: Int.self, a: aValue, b: bValue) {
             return res
        }
        if let res = equalAny(type: Bool.self, a: aValue, b: bValue) {
            return res
        }
        if let res = equalAny(type: Double.self, a: aValue, b: bValue) {
            return res
        }
        if let res = equalAny(type: Float.self, a: aValue, b: bValue) {
            return res
        }
        if let res = equalAny(type: String.self, a: aValue, b: bValue) {
            return res
        }
        if let res = equalAny(type: NSNumber.self, a: aValue, b: bValue) {
            return res
        }
        return nil
    }
    
    static func equalSet(aValue: Any, bValue: Any) -> Bool? {
        if let typeA = aValue as? [NSNumber], let typeB = bValue as? [NSNumber] {
            return typeA == typeB
        }
        if let typeA = aValue as? [Bool], let typeB = bValue as? [Bool] {
            return typeA == typeB
        }
        if let typeA = aValue as? [Int], let typeB = bValue as? [Int] {
            return typeA == typeB
        }
        if let typeA = aValue as? [Double], let typeB = bValue as? [Double] {
            return typeA == typeB
        }
        if let typeA = aValue as? [Float], let typeB = bValue as? [Float] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String], let typeB = bValue as? [String] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String: NSNumber], let typeB = bValue as? [String: NSNumber] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String: Bool], let typeB = bValue as? [String: Bool] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String: Int], let typeB = bValue as? [String: Int] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String: Double], let typeB = bValue as? [String: Double] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String: Float], let typeB = bValue as? [String: Float] {
            return typeA == typeB
        }
        if let typeA = aValue as? [String: String], let typeB = bValue as? [String: String] {
            return typeA == typeB
        }
        return nil
    }
}
