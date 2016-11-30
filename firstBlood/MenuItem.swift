//
//  MenuItem.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//  we use object mapper

import UIKit
import ObjectMapper

extension Menu
{
class MenuItem: Mappable {
    var itemType = ""
    var itemLabel = ""
    var itemUrl:  String?
    var children:[MenuItem]?
    
    //Impl. of Mappable protocol
    required convenience init?( map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        itemType    <- map["type"]
        itemLabel <- map["label"]
        itemUrl <- map["url"]
        children <- map["children"]
    }
    
}
}
