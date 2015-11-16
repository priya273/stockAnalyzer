//
//  AddStockTableCell.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/4/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
//Declare a protocall that the superview holding this view can receive 
//something is happened.
protocol AddStockTableCellDelegate
{
    func addButtonTapped(cell: AddStockTableCell);
}

class AddStockTableCell: UITableViewCell
{

    var delegate: AddStockTableCellDelegate?
    
    @IBOutlet weak var labelNameSymbol: UILabel!
    
    var symbolOrName : String = ""
    {
        didSet
        {
            if(symbolOrName != oldValue)
            {
                self.labelNameSymbol.text = symbolOrName;
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
    
    
    @IBAction func addNewStockSymbol(sender: AnyObject)
    {
        delegate?.addButtonTapped(self);
    }

}
