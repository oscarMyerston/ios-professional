//
//  AccpuntSummaryViewControllerTests.swift
//  BankeyTests
//
//  Created by Oscar David Myerston Vega on 2/12/22.
//

import Foundation
import XCTest

@testable import Bankey

class AccpuntSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeed() // This will trigger a call to viewDidLoad
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForNetworkError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        XCTAssertEqual("Network Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    
}

class MockProfileManager: ProfileManageable {
    
    var profile: Profile?
    var error: NetworkError?
    
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Bankey.Profile, Bankey.NetworkError>) -> Void) {
        if error != nil {
            completion(.failure(error!))
            return
        }
        profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
        completion(.success(profile!))
    }
    
}
