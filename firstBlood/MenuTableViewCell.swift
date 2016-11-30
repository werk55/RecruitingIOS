//
//  MenuTableViewCell.swift
//  firstBlood
//
//  Created by LTUR_DEV on 30.11.16.
//  Copyright © 2016 werk55. All rights reserved.
//

import UIKit


class MenuTableViewCell: UITableViewCell {
    
    var itemData: Menu.MenuItem?
    @IBOutlet var enrichedTextLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(data:Menu.MenuItem)
    {
        itemData = data
        if let text = itemData?.itemLabel { enrichedTextLabel?.text=text} //set the text
        if (itemData?.children != nil)     { self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator}
        if (itemData?.itemUrl != nil)     { self.accessoryType = UITableViewCellAccessoryType.detailButton}
        
        if let strType = itemData?.itemType
        {
        switch (strType)
        {
        case "section":
            self.selectionStyle =  UITableViewCellSelectionStyle.none
            self.contentView.backgroundColor=UIColor.gray
            self.accessoryType = UITableViewCellAccessoryType.none
            self.isUserInteractionEnabled = false
            
        default:
            self.contentView.backgroundColor=UIColor.white
            self.selectionStyle =  UITableViewCellSelectionStyle.default
            self.isUserInteractionEnabled = true
        }
        
        }
    }
    
}

