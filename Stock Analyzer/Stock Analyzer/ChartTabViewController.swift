//
//  ChartTabViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 12/4/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Alamofire

class ChartTabViewController: UITabBarController
{
    var stock : Stock!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
            print("Inside tab view controller  \(stock.symbol)")

            let parameters = [
                "parameters" : [
            "Normalized":false,
            "NumberOfDays":365,
            "DataPeriod":"Day",
            "LabelPeriod":"Day",
            "Elements": ["Symbol": "AAPL",
                         "Type":"price",
                         "Params":["c"]
                        ]]
            ]
        
        
        

        
        
       Alamofire.request(.GET, "http://dev.markitondemand.com/Api/v2/InteractiveChart/json?", parameters: parameters).responseJSON {
            JSON in
            print(JSON)
            do
            {
                let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
             
             print(values.valueForKey("Labels"))
                
            }
            catch
            {
                abort()
            }
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
