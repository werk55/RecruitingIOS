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

//extension Menu{

class MenuTableViewController: UITableViewController {

    var dataController: MenuDataControllerProtocol?  //TODO: use some protocol instead
    var rows: [Menu.MenuItem]?
    var selectedItem: Menu.MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //our current config
        dataController = appConfig.dataLayer

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = rows?.count
        return (numberOfRows ?? 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kMenuTableViewCell", for: indexPath) as! MenuTableViewCell

        // Configure the cell...
        if let data = (rows?[indexPath.row])  as Menu.MenuItem! {
            cell.setData(data: data )
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //figure out new context
        if let controller = segue.destination as? MenuTableViewController {
            
            let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)

            selectedItem = rows?[(selectedIndex?.row)!]
            controller.rows = selectedItem?.children
            controller.title = selectedItem?.itemLabel
        }
    }
    
}
//}
