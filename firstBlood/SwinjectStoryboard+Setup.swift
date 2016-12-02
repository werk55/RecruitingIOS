//
//  storyBoardExtension.swift
//  firstBlood
//
//  Created by LTUR_DEV on 02.12.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    
    class func setup() {
                
        // Registering concrete classes
        // You can use protocols instead and you'll be able to use Swinject in your Unit Tests too!
        // It's important to call .inObjectScope(.Container), so Swinject uses the same object instance
        // for all resolves
        

        //TODO..
        
        // Registering View Controller in the storyboard

        
        
        /*
        // Registering the second view controller
        defaultContainer.registerForStoryboard(SecondViewController.self) { r, c in
            c.database = r.resolve(DatabaseContext.self)
            c.networking = r.resolve(NetworkingContext.self)
            c.viewModel = r.resolve(ViewModelContext.self)
        }
        */
        
    }
}
