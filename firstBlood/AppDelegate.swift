//
//  AppDelegate.swift
//  firstBlood
//
//  Created by LTUR_DEV on 23.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var container: Container = {
        let container = Container()
        container.register(MenuDataControllerProtocol.self) { _ in Menu.MenuDataController() }
        
        container.registerForStoryboard(MenuTableViewController.self) { r, c in
            c.dataController = r.resolve(MenuDataControllerProtocol.self)
        }
        
        //! menu is in another storyboard 
        let secondStoryboard = SwinjectStoryboard.create(name: "RemoteMenu", bundle: nil, container: container)
        
        let menuViewController:UIViewController = secondStoryboard.instantiateViewController(withIdentifier: "kMenuRoot") as UIViewController
        
        container.register(UIViewController.self,name:"AppMenu") { _ in menuViewController}
        

        container.registerForStoryboard(ViewController.self) { r, c in
            c.menuViewController = r.resolve(UIViewController.self,name:"AppMenu")
        }
        
        return container
    }()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

