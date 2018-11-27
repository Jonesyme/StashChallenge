//
//  AchieveListViewTests.swift
//  StashTests
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import XCTest
@testable import Stash

class AchieveListViewTests: XCTestCase {

    var achievementList: [AchievementModel] = []
    var navController: UINavigationController?
    var listView: AchieveListView?
    
    override func setUp() {
        achievementList.append(AchievementModel(id: 1, level: "1", progress: 10, total: 100, bgImageUrl: "", accessible: true))
        achievementList.append(AchievementModel(id: 2, level: "2", progress: 20, total: 100, bgImageUrl: "", accessible: true))
        achievementList.append(AchievementModel(id: 3, level: "3", progress: 30, total: 100, bgImageUrl: "", accessible: true))
        
        listView = AchieveListWireFrame.mainstoryboard.instantiateViewController(withIdentifier: "AchieveListView") as? AchieveListView
        _ = listView?.view
    }
    
    func testViewSetupOK() {
        XCTAssertNotNil(listView)
    }
    
    func testDisplayAchievementList() {
        listView?.displayAchievementList(title: "Test", achievements: self.achievementList)
        let rowCount = listView?.tableView.numberOfRows(inSection: 0)
        XCTAssert(rowCount==3)
    }
    
    func testCellForRowDelegateCall() {
        listView?.displayAchievementList(title: "Test", achievements: self.achievementList)
        let cell = listView?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AchieveListCellView
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.contentView)
    }
    
}
