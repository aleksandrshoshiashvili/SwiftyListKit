//
//  AppDelegate.swift
//  SwiftyListKit
//
//  Created by Alexander Shoshiashvili on 04/05/2020.
//  Copyright (c) 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let examplesVC = ExamplesListViewController()
        let navigationController = UINavigationController(rootViewController: examplesVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

