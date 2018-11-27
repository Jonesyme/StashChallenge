//
//  AchieveListPresenter.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import Foundation
import UIKit

class AchieveListPresenter: AchieveListViewToPresenterProtocol {
    
    weak var view: AchieveListPresenterToViewProtocol?
    var interector: AchieveListPresentorToInterectorProtocol?
    var router: AchieveListPresenterToRouterProtocol?
    
    func updateAchieveListView() {
        interector?.fetchAchievements()
    }
    
    func updateImageForTableCell(atIndexPath indexPath:IndexPath, imageURL: String) {
        interector?.fetchImageForTableCell(atIndexPath: indexPath, imageURL: imageURL)
    }
}

extension AchieveListPresenter: AchieveListInterectorToPresenterProtocol {
    
    func didFetchAchievements(title: String?, achievements: [AchievementModel]) {
        view?.displayAchievementList(title: title, achievements: achievements)
    }
    
    func achievementsFetchFailed(){
        view?.displayErrorRetry()
    }
    
    func didFetchImageForTableCell(atIndexPath indexPath: IndexPath, image: UIImage) {
        view?.displayImageForTableCell(atIndexPath: indexPath, image: image)
    }
}

// AchieveListCellView -> Presenter

extension AchieveListPresenter: AchieveListCellViewToPresenterProtocol {
    
    class func formatPoints(value:Int) -> String {
        return String(value) + "pts"
    }
    
    class func calcProgressBarValue(progressValue:Int, totalValue:Int) -> Float {
        guard let progressFloat = Float.init(exactly:progressValue),
            let totalFloat = Float.init(exactly:totalValue) else {
                return 0.0
        }
        return progressFloat / totalFloat
    }
    
    class func calcBackgroundImageAlpha(accessibleValue: Bool?) -> CGFloat {
        guard let accessible = accessibleValue else {
            return 1.00
        }
        if (accessible) {
            return 1.00
        } else {
            return 0.65
        }
    }
}


