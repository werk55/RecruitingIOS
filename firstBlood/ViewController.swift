//
//  ViewController.swift
//  firstBlood
//
//  Created by LTUR_DEV on 23.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func launchMenu(sender: UIButton)
    {
        
        let viewController:UIViewController = UIStoryboard(name: "RemoteMenu", bundle: nil).instantiateViewController(withIdentifier: "kMenuRoot") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        
        self.present(viewController, animated: false, completion: nil)
        
    }
    
    /*
 
     
 */
}

