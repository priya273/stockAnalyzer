//
//  ChartTabViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 12/4/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
class ChartTabViewController: UITabBarController
{
    var stock : Stock!
    var sentiments : SentimentContract?
    
    override func viewDidLoad()
    {
        
      super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
