//
//  EquatablePropertyTests.swift
//  EquatablePropertyTests
//
//  Created by sungrow on 2018/3/26.
//  Copyright © 2018年 sungrow. All rights reserved.
//

import XCTest

class EquatablePropertyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // 在此添加测试用例初始化代码, 此方法在每个测试用例执行前执行
    }
    
    override func tearDown() {
        // 在此添加释放测试用例的资源代码, 此方法在每个测试用例执行后执行
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEqualString1() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        XCTAssert(strClass1 =*= strClass2, "字符串默认值比较")
    }
    
    func testEqualString2() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStrOpt = nil
        strClass2.propertyStrOpt = "test"
        XCTAssert(!(strClass1 =*= strClass2), "字符串可选值'nil'比较")
    }
    
    func testEqualString3() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStrOpt = "nil"
        strClass2.propertyStrOpt = "test"
        XCTAssert(!(strClass1 =*= strClass2), "字符串可选值不相等比较")
    }
    
    func testEqualString4() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStrOpt = "test"
        strClass2.propertyStrOpt = "test"
        XCTAssert(strClass1 =*= strClass2, "字符串可选值相等比较")
    }
    
    func testEqualString5() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStr = "test123"
        strClass2.propertyStr = "test"
        XCTAssert(!(strClass1 =*= strClass2), "字符串不相等比较")
    }
    
    func testEqualString6() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStr = "test123"
        strClass2.propertyStr = "test123"
        XCTAssert(strClass1 =*= strClass2, "字符串相等比较")
    }
    
    func testEqualSubClass1() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStr = "test123"
        strClass2.propertyStr = "test123"
        
        let subClass1 = SubClass()
        subClass1.propertyInt = 1
        let subClass2 = SubClass()
        subClass2.propertyInt = 15

        strClass1.subClass = subClass1
        strClass2.subClass = subClass2
        
        XCTAssert(!(strClass1 =*= strClass2), "子类不相等比较")
    }
    
    func testEqualSubClass2() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        strClass1.propertyStr = "test123"
        strClass2.propertyStr = "test123"
        
        let subClass1 = SubClass()
        subClass1.propertyInt = 15
        let subClass2 = SubClass()
        subClass2.propertyInt = 15
        
        strClass1.subClass = subClass1
        strClass2.subClass = subClass2
        
        XCTAssert(strClass1 =*= strClass2, "子类相等比较")
    }
    
}

class SuperClassStr: EquatableProperty {
    var propertyStr: String = ""
    var propertyStrOpt: String?
    
    var subClass: SubClass!
}

class SubClass {
    var propertyInt: Int = 0
    var propertyIntOpt: Int?
}
