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
                    result = result && equalProperty(aValue, b: bValue)
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
}

extension EquatableAny {
    static func equalAny<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        if (a as? T) != nil && (b as? T) == nil {
            return false
        }
        if (b as? T) != nil && (a as? T) == nil {
            return false
        }
        if (a as? [T]) != nil && (b as? [T]) == nil {
            return false
        }
        if (b as? [T]) != nil && (a as? [T]) == nil {
            return false
        }
        if (a as? [String: T]) != nil && (b as? [String: T]) == nil {
            return false
        }
        if (b as? [String: T]) != nil && (a as? [String: T]) == nil {
            return false
        }
        if let a = a as? T, let b = b as? T {
            return a == b
        }
        if let a = a as? [T], let b = b as? [T] {
            return a == b
        }
        if let a = a as? [String: T], let b = b as? [String: T] {
            return a == b
        }
        return nil
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
}
