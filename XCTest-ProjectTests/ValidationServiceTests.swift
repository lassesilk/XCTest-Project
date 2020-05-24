//
//  ValidationServiceTests.swift
//  XCTest-ProjectTests
//
//  Created by Lasse Silkoset on 24/05/2020.
//  Copyright © 2020 Lasse Silkoset. All rights reserved.
//

@testable import XCTest_Project
import XCTest

class ValidationServiceTests: XCTestCase {

    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }

    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    func test_is_valid_username() throws {
        XCTAssertNoThrow(try validation.validateUsername("lassesilk"))
    }
    
    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("las")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "very long user name1"
        
        XCTAssertTrue(username.count == 20)
        
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
}
