//
//  StockTableViewCell.swift
//  Stock Analysis
//
//  Created by Naga sarath Thodime on 10/13/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //Declaring variables for this class
    //It will have a ticker Symbol,
    //price
    //increase / decrease
    
    
    var name : String = ""
        {
        didSet
        {
            if(name != oldValue)
            {
                nameLabel.text = name;
            }
        }
        
    }
    
    
    var symbol : String = ""
        {
        didSet
        {
            if(symbol != oldValue)
            {
                symbolLabel.text = symbol;
            }
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
