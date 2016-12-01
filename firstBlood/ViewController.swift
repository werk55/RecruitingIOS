//
//  ViewController.swift
//  firstBlood
//
//  Created by LTUR_DEV on 23.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView?
    
    //MARK: observers
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.handle(withNotification:)), name: .openUrlNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleMenu))
        
        //TODO: check if this is working
        if let backBtn = self.navigationItem.backBarButtonItem
        {
            self.navigationItem.leftBarButtonItems = [backBtn, menuBtn]
        }
        else
        {
            self.navigationItem.leftBarButtonItems = [menuBtn]
        }
        
        //s  self.navigationItem.leftBarButtonItem = menuBtn
        
    }
    
    @objc func handleMenu()->()
    {
        let viewController:UIViewController = UIStoryboard(name: "RemoteMenu", bundle: nil).instantiateViewController(withIdentifier: "kMenuRoot") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        
        viewController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        
        self.present(viewController, animated: true, completion: nil)
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
    
    @objc func handle(withNotification notification : NSNotification) {
        
        if let menuItem = notification.object as! Menu.MenuItem?
        {
            DispatchQueue.main.async {
                
                self.dismiss(animated: true, completion: nil)
                
                
                switch (menuItem.itemType)
                {
                case "external-link":
                    UIApplication.shared.openURL(URL(string: menuItem.itemUrl!)!) //TODO warn 10.x
                    
                default:
                    let loadRequest = URLRequest(url: URL(string: menuItem.itemUrl!)!)
                    self.webView?.loadRequest(loadRequest)
                }
            }
            
            print("RECEIVED SPECIFIC NOTIFICATION: \(notification)")
        }
    }

}

