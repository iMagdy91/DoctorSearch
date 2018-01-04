//
//  DoctorSearchTests.swift
//  DoctorSearchTests
//
//  Created by Mohamed Magdy on 02.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import XCTest
@testable import DoctorSearch

class DoctorSearchTests: XCTestCase {
    
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    func testAPIResponse() {
        
        let expectations: XCTestExpectation = expectation(description: "Testing Doctors API")
        let doctorStore  : DSDoctorSearchStore      = DSDoctorSearchStore()
        doctorStore.getDoctorsListForLocation(latitude: 50, longitude: 12, searchText: nil, success: { (model) in
            let doctors: [DSDoctorViewModel]? = model as? [DSDoctorViewModel]
            XCTAssertNotNil(doctors)
            XCTAssert(doctors?.count == 20)
            XCTAssertNotNil(doctors?.first?.name)
            expectations.fulfill()

        }) { (error) in
            XCTFail("##ERROR happened: \(error)")
            expectations.fulfill()

        }
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsTimeout error: \(error)")
            }
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {[weak self] in
            self?.testAPIResponse()
        }
    }

    
}
