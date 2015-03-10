//
//  tests.swift
//  DumpsterSwift
//
//  Created by Joel Wasserman on 3/9/15.
//  Copyright (c) 2015 IVET. All rights reserved.
//

import XCTest

class tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testVC() {
        let viewController = ViewController()
        viewController.buildQuestions()
        
        XCTAssertNotNil(viewController, "view did not load")
        XCTAssertNotNil(viewController.questionArrayFirst, "questions didn't load properly")
        XCTAssertNotNil(viewController.answerArrayFirst, "Answers didn't load properly")
    }
    
    func testQVC() {
        let viewController = QuestionViewController()
        viewController.buildQuestions()
        
        XCTAssertNotNil(viewController, "view did not load")
        XCTAssertNotNil(viewController.questionArray, "questions didn't load properly")
        XCTAssertNotNil(viewController.answerArray, "Answers didn't load properly")
        
        viewController.populateQuestions()
        XCTAssertNotNil(viewController.buttonArray, "button array not loaded properly")
        XCTAssertNotNil(viewController.answerLabelArray, "Answer label array not loaded properly")
    }
    
    func testSVC() {
        let viewController = StatsViewController()
        
        XCTAssertNotNil(viewController, "view did not load")
        XCTAssertNotNil(viewController.labelOne, "label one not set correctly")
        XCTAssertNotNil(viewController.labelTwo, "label two not set correctly")
        XCTAssertNotNil(viewController.labelThree, "label three not set correctly")
        XCTAssertNotNil(viewController.labelFour, "label four not set correctly")
        XCTAssertNotNil(viewController.labelFive, "label five not set correctly")
        
    }
}
