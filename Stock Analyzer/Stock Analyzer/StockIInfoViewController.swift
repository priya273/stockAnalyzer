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
            //print(JSON)
            do
            {
                let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                self.open.text = String(format:"%.2f", Double(values.valueForKey("Open") as! NSNumber))
                self.high.text = String(format:"%.2f", Double(values.valueForKey("High") as! NSNumber))
                self.low.text = String(format:"%.2f", Double(values.valueForKey("Low") as! NSNumber))
                
    
                self.marketCap.text = self.computeDouble(Double(values.valueForKey("MarketCap") as! NSNumber))
                
                self.lastPrice.text = String(format:"%.2f", Double(values.valueForKey("LastPrice") as! NSNumber))
               // self.vol.text = (values.valueForKey("Volume") as! NSNumber).stringValue
                self.vol.text = self.computeInt(Double(values.valueForKey("Volume") as! NSNumber))
            }
            catch
            {
                abort()
            }
        }
  
                   // Do any additional setup after loading the view.
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
    override func viewDidAppear(animated: Bool)
    {
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
