//
//  main.swift
//  EquatableProperty
//
//  Created by sungrow on 2018/3/22.
//  Copyright © 2018年 sungrow. All rights reserved.
//

import Foundation

class Person: EquatableProperty {
    
    let name: String
    var age: Float?
    var books: [String]?
    
    init(_ name: String) {
        self.name = name
    }
    
//    static func ==(lhs: Person, rhs: Person) -> Bool {
//        return Person.equalProperty(lhs, b: rhs)
//    }
}

let p1 = Person("p1")
p1.age = 12.3
p1.books = ["a", "b"]
let p2 = Person("p1")
p2.age = 12.3
p2.books = ["a", "c"]

//print("p1 == p2 \(p1 == p2)")


struct People: EquatableProperty {
    let name: String
    let empole: Empole
}

struct Empole: EquatableProperty {
    let age: Int
}

let pe1 = People(name: "ha", empole: Empole(age: 13))
let pe2 = People(name: "ha", empole: Empole(age: 13))

//print("pe1 == pe2 \(People.equalProperty(pe1, b: pe2))")

let t1: EquatableProperty = Empole(age: 12)
let t2: EquatableProperty = Person("123")
print("t1 == t2 \(pe1 =*= pe1))")

print("t1 == t2 \(pe1 =*= pe2)")
