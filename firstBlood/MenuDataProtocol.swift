//
//  MenuDataProtocol.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import Foundation

protocol MenuDataControllerProtocol
{
    //lets fetch our menu
    func menuItems(operation:  @escaping Menu.menuListHandler);
}
