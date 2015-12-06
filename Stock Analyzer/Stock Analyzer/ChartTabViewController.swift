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

    
    override func viewDidLoad()
    {
        
      super.viewDidLoad()
        
       //var   // let params = "{\"Normalized\":false,\"NumberOfDays\":365,\"DataPeriod\":\"Day\",\"Elements\":[{\"Symbol\":\"AAPL\",\"Type\":\"price\",\"Params\":[\"c\"]}]}"
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    func makingNetworkCalls()
 //   {
        
//        let params = "{\"Normalized\":false,\"NumberOfDays\":365,\"DataPeriod\":\"Day\",\"Elements\":[{\"Symbol\":\"\(stock.symbol!)\",\"Type\":\"price\",\"Params\":[\"c\"]}]}"
//        //let escapedParams = params.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        
//        Alamofire.request(.GET, "http://dev.markitondemand.com/Api/v2/InteractiveChart/json", parameters: ["parameters" : params]).responseJSON {
//            JSON in
//            //print(JSON)
//            do
//            {
//                let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
//                if(values.valueForKey("Position") != nil)
//                {
//                    let Positions = values.valueForKey("Positions") as! [Double]
//                    let Dates = values.valueForKey("Dates") as! [String]
//                    
//                    let values = (((values.valueForKey("Elements") as! NSArray).valueForKey("DataSeries") as! NSArray ).valueForKey("close") as! NSArray).valueForKey("values") as! NSArray
//                    
//                }
//                
//                
//            }
//            catch
//            {
//                abort()
//            }
//        }

 //   }
    
    
    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    

}
