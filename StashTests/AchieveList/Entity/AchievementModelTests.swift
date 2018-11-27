//
//  AchievementModelTests.swift
//  StashTests
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import XCTest
@testable import Stash

class AchievementModelTests: XCTestCase {

    var wrapperResult: AchievementWrapper?
    var achievementsSourceURL: URL {
        let bundle = Bundle(for: type(of: self))
        let mockJSON = bundle.url(forResource: "achievements", withExtension: "json")
        return mockJSON!
    }
    
    override func setUp() {
        let data = try? Data(contentsOf: achievementsSourceURL)
        let decoder = JSONDecoder()
        wrapperResult = try? decoder.decode(AchievementWrapper.self, from: data!)
    }

    func testSetupOK() {
        XCTAssertNotNil(wrapperResult)
    }

    func testBasicModelDeserialization() {
        XCTAssertNotNil(wrapperResult?.overview)
        XCTAssertNotNil(wrapperResult?.overview?.title)
        XCTAssert(wrapperResult?.overview?.title == "Smart Investing")
        XCTAssertNotNil(wrapperResult?.achievements)
    }
    
    func testAchievementModelDeserialization() {
        let achievement:AchievementModel? = wrapperResult?.achievements?.first
        XCTAssertNotNil(achievement)
        
        XCTAssert(achievement?.id == 4)
        XCTAssert(achievement?.level == "1")
        XCTAssert(achievement?.progress == 10)
        XCTAssert(achievement?.total == 50)
        XCTAssert(achievement?.accessible == true)
    }
}
