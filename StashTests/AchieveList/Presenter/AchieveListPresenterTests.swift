//
//  AchieveListPresenterTests.swift
//  StashTests
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import XCTest
@testable import Stash

class AchieveListPresenterTests: XCTestCase {
    
    var presenter = AchieveListPresenter()
    var interactor = TestInteractor()
    var view = TestView()
    
    override func setUp() {
        presenter.view = view
        presenter.interector = interactor
        interactor.presenter = presenter
    }
    
    // Presenter -> Interactor
    
    func testUpdateAchieveListView() {
        presenter.updateAchieveListView()
        XCTAssertTrue(interactor.didFetchAchievementsCalled)
    }
    
    func testUpdateImageForTableCell() {
        presenter.updateImageForTableCell(atIndexPath: IndexPath(row: 0, section: 0), imageURL: "")
        XCTAssertTrue(interactor.didFetchImageForTableCellCalled)
    }
    
    // Presenter -> View
    
    func testDidFetchAchievements() {
        presenter.didFetchAchievements(title: "TestTitle", achievements: [])
        XCTAssertTrue(view.displayAchievementListCalled)
    }
    
    func testAchievementsFetchFailed() {
        presenter.achievementsFetchFailed()
        XCTAssertTrue(view.displayErrorRetryCalled)
    }
    
    func testDidFetchImageForTableCell() {
        presenter.didFetchImageForTableCell(atIndexPath: IndexPath(row: 0, section: 0), image: UIImage(named:"placeholder")!)
        XCTAssertTrue(view.displayImageForTableCellCalled)
    }
    
    // static view helpers

    func testFormatPoints() {
        let testStr1 = AchieveListPresenter.formatPoints(value: 10)
        let testStr2 = AchieveListPresenter.formatPoints(value: 20)
        let testStr3 = AchieveListPresenter.formatPoints(value: 0)
        let testStr4 = AchieveListPresenter.formatPoints(value: -999)
        XCTAssert(testStr1=="10pts")
        XCTAssert(testStr2=="20pts")
        XCTAssert(testStr3=="0pts")
        XCTAssert(testStr4=="-999pts")
    }
    
    func testCalcProgressBarValue() {
        let testBarValue1 = AchieveListPresenter.calcProgressBarValue(progressValue: 10, totalValue: 100)
        let testBarValue2 = AchieveListPresenter.calcProgressBarValue(progressValue: 99, totalValue: 1000)
        let testBarValue3 = AchieveListPresenter.calcProgressBarValue(progressValue: 1231, totalValue: 100)
        XCTAssert(testBarValue1==0.10)
        XCTAssert(testBarValue2==0.099)
        XCTAssert(testBarValue3==12.31)
    }
    
    func testCalcBackgroundImageAlpha() {
        let testAlphaTrue = AchieveListPresenter.calcBackgroundImageAlpha(accessibleValue: true)
        let testAlphaFalse = AchieveListPresenter.calcBackgroundImageAlpha(accessibleValue: false)
        XCTAssert(testAlphaTrue==1.00)
        XCTAssert(testAlphaFalse==0.65)
    }
}

// MARK: - Mock Interfaces
    
extension AchieveListPresenterTests {
    
    class TestInteractor: AchieveListPresentorToInterectorProtocol {
        
        weak var presenter: AchieveListInterectorToPresenterProtocol?
        var didFetchAchievementsCalled = false
        var didFetchImageForTableCellCalled = false

        func fetchAchievements() {
            didFetchAchievementsCalled = true
        }
        func fetchImageForTableCell(atIndexPath indexPath: IndexPath, imageURL: String) {
            didFetchImageForTableCellCalled = true
        }
    }
    
    class TestView: AchieveListPresenterToViewProtocol {
        
        var displayAchievementListCalled = false
        var displayErrorRetryCalled = false
        var displayImageForTableCellCalled = false
        
        func displayAchievementList(title: String?, achievements: [AchievementModel]) {
            displayAchievementListCalled = true
        }
        func displayErrorRetry() {
            displayErrorRetryCalled = true
        }
        func displayImageForTableCell(atIndexPath indexPath: IndexPath, image: UIImage) {
            displayImageForTableCellCalled = true
        }
    }
}
