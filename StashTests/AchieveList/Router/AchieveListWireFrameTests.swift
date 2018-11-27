//
//  AchieveListWireFrameTests.swift
//  StashTests
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import XCTest
@testable import Stash

class AchieveListWireFrameTests: XCTestCase {

    func testCreateAchieveListModule() {
        
        let navController = AchieveListWireFrame.createAchieveListModule() as? UINavigationController
        XCTAssertNotNil(navController)
        
        let view = navController?.children.first as? AchieveListView
        XCTAssertNotNil(view)
        
        XCTAssertNotNil(view?.presenter)
        XCTAssertNotNil(view?.presenter?.view)
        XCTAssertNotNil(view?.presenter?.router)
        XCTAssertNotNil(view?.presenter?.interector?.presenter)
    }
    
}
