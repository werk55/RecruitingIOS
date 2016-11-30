//
//  MenuDataController.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//
// this will fetch our data

import UIKit
import Alamofire
import AlamofireObjectMapper

extension Menu{

    public typealias menuListHandler = ([Menu.MenuItem]?)->()

    class MenuDataController: MenuDataControllerProtocol {
        
        var menuItems :[MenuItem]?
        
       // public typealias menuListHandler = ([Menu.MenuItem]?)->()
        //lets fetch our menu
        func menuItems(operation:  @escaping menuListHandler)
        {
            let url =  EPConfig.base + EPConfig.path
            
            //kiss cache - fetch it only one time
            if (menuItems != nil){ operation(menuItems)}
            
            //request data from server
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers:["x-api-key":EPConfig.shrooms])
                .validate(statusCode: 200..<300)
                .responseObject { (response: DataResponse<MenuItemRoot>) in
                    
                    let items = response.result.value  // books array
                    self.menuItems = items?.children //lets store it later
                    
                    return operation(items?.children)
            }
        }
    }
}
