//
//  DeleteStockTableCell.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/4/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class DeleteStockTableCell: UITableViewCell
{

    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    var symbol : String = ""
    {
        didSet
        {
            if(symbol != oldValue)
            {
                labelSymbol.text = symbol;
            }
        }
            
    }
    
    var name : String = ""
        {
            didSet
            {
                if(name != oldValue)
                {
                    labelName.text = name;
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
