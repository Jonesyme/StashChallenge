//
//  AchieveListInteractorTests.swift
//  StashTests
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import XCTest
@testable import Stash


class AchieveListInteractorTests: XCTestCase {
    
    var presenter = TestPresenter()
    var interactor = AchieveListInterector()
    
    override func setUp() {
        interactor.presenter = presenter
    }

    func testDidFetchAchievements() {
        let testExpectation = expectation(description: #function)
        interactor.fetchAchievements()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(self.presenter.didFetchAchievementsCalled)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testDidFetchImageForTableCell() {
        let testImageUrl = "https://www.gstatic.com/webp/gallery3/1.png"
        
        let testExpectation = expectation(description: #function)
        interactor.fetchImageForTableCell(atIndexPath: IndexPath(item: 0, section: 0), imageURL: testImageUrl)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(self.presenter.didFetchImageForTableCellCalled)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

// MARK: - Mock Interfaces

extension AchieveListInteractorTests {

    class TestPresenter: AchieveListInterectorToPresenterProtocol {
        
        var didFetchAchievementsCalled = false
        var achievementsFetchFailedCalled = false
        var didFetchImageForTableCellCalled = false
        
        func didFetchAchievements(title: String?, achievements: [AchievementModel]) {
            self.didFetchAchievementsCalled = true
        }
        func achievementsFetchFailed(){
            self.achievementsFetchFailedCalled = true
        }
        func didFetchImageForTableCell(atIndexPath indexPath: IndexPath, image: UIImage) {
            self.didFetchImageForTableCellCalled = true
        }
    }
    
}
