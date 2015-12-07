//
//  StockIInfoViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/29/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Alamofire

class StockIInfoViewController: UIViewController
{
    
    let characterForBigValues = ["K","M","B", "T"]
    
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var high: UILabel!
    
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var marketCap: UILabel!
    
    @IBOutlet weak var vol: UILabel!
    
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var lastPrice: UILabel!
    var stock : Stock!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(stock.symbol!)
        stockName.text = stock.name!
        Alamofire.request(.GET, "http://dev.markitondemand.com/Api/v2/Quote/json?", parameters: ["symbol" : self.stock.symbol!]).responseJSON {
            JSON in
           // print(JSON)
            do
            {
                let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
               
                self.stock.open! =  values.valueForKey("Open") as! NSNumber
                self.open.text = String(format:"%.2f", Double(self.stock.open!))
                
                self.stock.high! = values.valueForKey("High") as! NSNumber
                self.high.text = String(format:"%.2f", Double(self.stock.high!))
                
                self.stock.low! =  values.valueForKey("Low") as! NSNumber
                self.low.text = String(format:"%.2f", Double(self.stock.low!))
                
                self.stock.marketCap! = values.valueForKey("MarketCap") as! NSNumber
                self.marketCap.text = self.computeDouble(Double( self.stock.marketCap!))
                
                self.stock.lastPrice! = values.valueForKey("LastPrice") as! NSNumber
                self.lastPrice.text = String(format:"%.2f", Double(values.valueForKey("LastPrice") as! NSNumber))

                self.stock.volumn! = values.valueForKey("Volume") as! NSNumber
                self.vol.text = self.computeInt(Double(values.valueForKey("Volume") as! NSNumber))
                
                self.stock.change! = values.valueForKey("Change") as! NSNumber
                self.stock.changePercent! = values.valueForKey("ChangePercent") as! NSNumber
            
            }
            catch
            {
                   self.alertTheUserSomethingWentWrong("TO DO", message:"Couldnt update other fields to \(self.stock.symbol!)", actionTitle: "okay")
                //abort()
            }
        }
      }
    
    func computeInt(value: Double) -> String
    {
        var val: Double = value;
        var index = -1;
        while(true)
        {
            let compute = val / 1000.0
            
            if(compute > 1)
            {
                val = compute;
                index++;
                //  print(val)
            }
            else
            {
                break;
            }
        }
        
        let val2 = (index >= 0) ? characterForBigValues[index] : ""
        
        
        return String(Int(val)) + val2;

    }
    
    func computeDouble(value: Double) ->String
    {
        
        var val: Double = value;
        var index = -1;
        while(true)
        {
            let compute = val / 1000.0
            
            if(compute > 1)
            {
                val = compute;
                index++;
              //  print(val)
            }
            else
            {
                break;
            }
        }
      
        let val2 = (index >= 0) ? characterForBigValues[index] : ""
        let val1 = (index < 0) ? String(val) : String(format:"%.1f", val)
        
        return val1 + val2;
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertTheUserSomethingWentWrong(titleforController: String, message : String, actionTitle: String)
    {
        let controller = UIAlertController(title: titleforController , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Cancel, handler: nil)
        controller.addAction(action)
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    

}
