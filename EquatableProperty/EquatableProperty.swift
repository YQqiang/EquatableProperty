//
//  EquatableProperty.swift
//  EquatableProperty
//
//  Created by sungrow on 2018/3/24.
//  Copyright © 2018年 sungrow. All rights reserved.
//

import Foundation

protocol EquatableProperty: EquatableAny {
    static func equalProperty<T>(_ a: T, b: T) -> Bool
}

extension EquatableProperty {
    static func equalProperty<T>(_ a: T, b: T) -> Bool {
        let aMirro = Mirror(reflecting: a)
        let bMirro = Mirror(reflecting: b)
        var result = true
        for aChild in aMirro.children {
            for bChild in bMirro.children {
                let (aKey, aValue) = (aChild.label, aChild.value)
                let (bKey, bValue) = (bChild.label, bChild.value)
                if aKey == bKey {
                    let a = type(of: aValue)
                    debugPrint("------ \(a)")
                    if aValue is EquatableProperty {
                        if bValue is EquatableProperty {
                            result = equalProperty(aValue, b: bValue)
                        }
                    }
                    if let res = equalAny(type: Int.self, a: aValue, b: bValue) {
                        result = result && res
                    }
                    if let res = equalAny(type: Bool.self, a: aValue, b: bValue) {
                        result = result && res
                    }
                    if let res = equalAny(type: Double.self, a: aValue, b: bValue) {
                        result = result && res
                    }
                    if let res = equalAny(type: Float.self, a: aValue, b: bValue) {
                        result = result && res
                    }
                    if let res = equalAny(type: String.self, a: aValue, b: bValue) {
                        result = result && res
                    }
                    if let res = equalAny(type: NSNumber.self, a: aValue, b: bValue) {
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
        guard let a = a as? T, let b = b as? T else { return nil }
        return a == b
    }
}
