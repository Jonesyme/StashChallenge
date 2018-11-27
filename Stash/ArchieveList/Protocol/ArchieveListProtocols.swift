//
//  ArchieveListProtocols.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import Foundation
import UIKit


protocol AchieveListPresenterToRouterProtocol: class {
    static func createAchieveListModule() -> UIViewController
}

protocol AchieveListPresenterToViewProtocol: class {
    func displayAchievementList(title: String?, achievements: [AchievementModel])
    func displayErrorRetry()
    func displayImageForTableCell(atIndexPath indexPath: IndexPath, image: UIImage)
}

protocol AchieveListInterectorToPresenterProtocol: class {
    func didFetchAchievements(title: String?, achievements: [AchievementModel])
    func achievementsFetchFailed()
    func didFetchImageForTableCell(atIndexPath indexPath: IndexPath, image: UIImage)
}

protocol AchieveListPresentorToInterectorProtocol: class {
    var presenter: AchieveListInterectorToPresenterProtocol? {get set}
    func fetchAchievements()
    func fetchImageForTableCell(atIndexPath indexPath: IndexPath, imageURL: String)
}

protocol AchieveListViewToPresenterProtocol: class {
    var view: AchieveListPresenterToViewProtocol? {get set}
    var interector: AchieveListPresentorToInterectorProtocol? {get set}
    var router: AchieveListPresenterToRouterProtocol? {get set}
    func updateAchieveListView()
    func updateImageForTableCell(atIndexPath indexPath:IndexPath, imageURL: String)
}

protocol AchieveListCellViewToPresenterProtocol: class {
    static func formatPoints(value:Int) -> String
    static func calcProgressBarValue(progressValue:Int, totalValue:Int) -> Float
    static func calcBackgroundImageAlpha(accessibleValue: Bool?) -> CGFloat
}

