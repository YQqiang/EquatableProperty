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
    
    func testEqualString() {
        let strClass1 = SuperClassStr()
        let strClass2 = SuperClassStr()
        XCTAssert(strClass1 =*= strClass2, "String 类型测试1通过")
        
        strClass1.propertyStrOpt = nil
        strClass2.propertyStrOpt = "test"
        XCTAssert(!(strClass1 =*= strClass2), "String 类型测试2通过")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // 性能测试代码
        }
    }
    
}

class SuperClassStr: EquatableProperty {
//    var propertyStr: String = ""
    var propertyStrOpt: String?
}
