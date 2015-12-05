//
//  PopUpView.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 12/1/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class PopUpView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var label : UILabel?
    
    override init(frame: CGRect)
    {
        //super.init(coder: aDecoder)
        super.init(frame: frame)
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 90))
        label!.backgroundColor = UIColor.clearColor()
        
        label!.textColor = UIColor.blackColor()
        label!.textAlignment = .Center
        label!.lineBreakMode = .ByWordWrapping
        label!.numberOfLines = 2
        label!.font = UIFont.systemFontOfSize(14)

        self.addSubview(label!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func intrinsicContentSize() -> CGSize
    {
        return CGSize(width: 150, height: 50)
    }
    
    
}
