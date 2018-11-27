//
//  AchieveListCellViewTests.swift
//  StashTests
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import XCTest
@testable import Stash

class AchieveListCellViewTests: XCTestCase {
    
    var achievementList: [AchievementModel] = []
    var navController: UINavigationController?
    var listView: AchieveListView?
    var cellView: AchieveListCellView?
    
    override func setUp() {
        achievementList.append(AchievementModel(id: 1, level: "1", progress: 10, total: 100, bgImageUrl: "", accessible: true))
        listView = AchieveListWireFrame.mainstoryboard.instantiateViewController(withIdentifier: "AchieveListView") as? AchieveListView
        _ = listView?.view
        
        listView?.displayAchievementList(title: "Test", achievements: self.achievementList)
        cellView = listView?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AchieveListCellView
    }

    func testCellViewSetupOK() {
        XCTAssertNotNil(cellView)
    }
    
    func testCellViewConfigurationWithAchievementModel1() {
        cellView?.set(forAchievement: AchievementModel(id: 1, level: "1", progress: 10, total: 100, bgImageUrl: "", accessible: true))
        XCTAssert(cellView?.levelLabel.text == "1")
        XCTAssert(cellView?.totalMinLabel.text == "10pts")
        XCTAssert(cellView?.totalMaxLabel.text == "100pts")
        XCTAssert(cellView?.bgImageView.alpha == 1.0)
    }
    
    func testCellViewConfigurationWithAchievementModel2() {
        cellView?.set(forAchievement: AchievementModel(id: 2, level: "11", progress: 10, total: 100, bgImageUrl: "", accessible: false))
        XCTAssert(cellView?.levelLabel.text == "11")
        XCTAssert(cellView?.totalMinLabel.text == "10pts")
        XCTAssert(cellView?.totalMaxLabel.text == "100pts")
        XCTAssert(cellView?.bgImageView.alpha.isLess(than: 0.66)==true)
    }
}
