//
//  AppDelegate.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let achieveListView = AchieveListWireFrame.createAchieveListModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = achieveListView
        window?.makeKeyAndVisible()
        
        return true
    }
}

