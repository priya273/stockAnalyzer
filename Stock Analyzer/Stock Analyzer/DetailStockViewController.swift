//
//  DetailStockViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/1/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class DetailStockViewController: UIViewController
{
    var stock : Stock!
    var Chart : ChartContract!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true;
        // Do any additional setup after loading the view.
    }
    
  
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func getStock () -> Stock
    {
        return self.stock;
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ShowStockDetail")
        {
            let vc = segue.destinationViewController as! StockIInfoViewController
            vc.stock = stock;
        }
        else if(segue.identifier == "ShowChart")
        {
            let vc = segue.destinationViewController as! ChartTabViewController
            vc.stock = stock;
        }
    }
    
    
  }
