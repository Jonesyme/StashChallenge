//
//  AchieveListRouter.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import Foundation
import UIKit

class AchieveListWireFrame: AchieveListPresenterToRouterProtocol {
    
    class func createAchieveListModule() -> UIViewController {
        
        if let navController = mainstoryboard.instantiateViewController(withIdentifier: "NavController") as? UINavigationController,
            let view = navController.children.first as? AchieveListView {
            
            let presenter: AchieveListViewToPresenterProtocol & AchieveListInterectorToPresenterProtocol = AchieveListPresenter()
            let interactor: AchieveListPresentorToInterectorProtocol = AchieveListInterector()
            let router: AchieveListPresenterToRouterProtocol = AchieveListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interector = interactor
            interactor.presenter = presenter
            
            return navController
        }

        return UINavigationController()
    }

    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
