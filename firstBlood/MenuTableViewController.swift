//
//  MenuTableViewController.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

//rule of thumb is here "section" display children on the same page
//-node- display children on a second page - so section leads to sections and nodes to a new page

import UIKit

class MenuTableViewController: UITableViewController {
    
    var dataController: MenuDataControllerProtocol?
    var rows: [Menu.MenuItem]?
    var selectedItem: Menu.MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let backBtn = UIBarButtonItem()
        backBtn.title=""
        self.navigationItem.backBarButtonItem = backBtn
        
        let rigthBtn = UIBarButtonItem(image: UIImage(named: "28-28_cross"), style: .plain, target: self, action: #selector(handleClose))
        
        rigthBtn.title=""
        
        self.navigationItem.rightBarButtonItem = rigthBtn
    }
    
    @objc func handleClose()->()
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (rows == nil){
            if let ctrl = dataController
            {
                ctrl.menuItems(operation: {(items: [Menu.MenuItem]?)->() in
                    DispatchQueue.main.async {
                        self.rows=items
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let numberOfRows = rows?.count
        return (numberOfRows ?? 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 1
        
        if let data = (rows?[section]) as Menu.MenuItem!
        {
            if (data.itemType==Menu.itemType.section.rawValue){
                numberOfRows = numberOfRows + (data.children?.count)!
            }
        }
        
        return numberOfRows
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kMenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        // Configure the cell...
        if let data = (rows?[indexPath.section])  as Menu.MenuItem! {
            cell.setData(data: data )
            if (indexPath.row>0)
            {
                if let rowData = data.children?[indexPath.row-1]{
                    cell.setData(data: rowData )
                }
            }
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //figure out new context
        if let controller = segue.destination as? MenuTableViewController {
            
            let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            selectedItem = rows?[(selectedIndex?.section)!]
            
            if ((selectedIndex?.row)!>0)
            {
                if let rowData = selectedItem?.children?[(selectedIndex?.row)!-1]{
                    selectedItem = rowData
                }
            }
            
            controller.rows = selectedItem?.children
            controller.title = selectedItem?.itemLabel
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool {
        
        if let knowning = sender as! MenuTableViewCell?
        {
            let item = knowning.itemData
            switch ((item?.itemType)! as String) //TODO - it looks odd
            {
            case  Menu.itemType.link.rawValue:
                //let somebody open this url
                NotificationCenter.default.post(name: .openUrlNotification, object: item)
                return false
            case  Menu.itemType.externalLink.rawValue:
                //let somebody open this url
                NotificationCenter.default.post(name: .openUrlNotification, object: item)
                return false
            default:
                return true
            }
        }
        
        return true
    }
}
