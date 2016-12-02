//
//  appConfig.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import Foundation
import Swinject

struct appConfig
{
    //static let dataLayer = Menu.MenuDataController()
    static let configuration: Container = {
        let configContainer = Container()
        configContainer.register(MenuDataControllerProtocol.self) { _ in Menu.MenuDataController()
        }
        
        let menuViewController:UIViewController = UIStoryboard(name: "RemoteMenu", bundle: nil).instantiateViewController(withIdentifier: "kMenuRoot") as UIViewController
        
        configContainer.register(UIViewController.self,name:"AppMenu") { _ in menuViewController
        }
        
        return configContainer
    }()
}
