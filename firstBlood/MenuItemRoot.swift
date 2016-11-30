//
//  MenuItemRoot.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import UIKit
import ObjectMapper


extension Menu{
    class MenuItemRoot: Mappable {
        var children:[MenuItem]?
        required convenience init?( map: Map) {
            self.init()
        }
        
        func mapping(map: Map) {
            
            children <- map["navigationEntries"]
        }
    }
}

