//
//  ChartConsumer.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation
import Alamofire

protocol ChartConsumerDelegate
{
    func ServiceFailed(message: String, exception: Bool)
    func ServicePassed(chart: ChartContract, dataAvailable: Bool)
}

class ChartConsumer
{
    var delegate: ChartConsumerDelegate!
    
    init()
    {
        
    }
    
    func Run(symbol: String, id: String?)
    {
        
            let url = NSURL(string: "http://stockanalyzer.azurewebsites.net/api/chart/\(symbol)");
            
            let headers = ["id" : "\(id)"]
            
            Alamofire.request(.GET, url!, parameters: headers).responseJSON
                {
                    JSON in
                    do
                    {
                        let serialization = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                        
                        if(serialization.valueForKey("Elements")?.count > 0)
                        {
                            let dataAvailable = true
                            let chart = ChartContract()
                            
                            chart.Positions = serialization.valueForKey("Positions") as! [Double]
                            chart.Dates = serialization.valueForKey("Dates") as! [String]
                            
                      
                            
                            let value = (((serialization.valueForKey("Elements") as! NSArray).valueForKey("DataSeries") as! NSArray ).valueForKey("close") as! NSArray).valueForKey("values") as! NSArray
                            chart.Prices = value[0] as! [Double]
                            
                            self.delegate?.ServicePassed(chart, dataAvailable: dataAvailable)
                        }
                        else
                        {
                            self.delegate?.ServiceFailed("No data availabe to load", exception: false)
                        }

                    }
                    catch
                    {
                         self.delegate?.ServiceFailed("something went wrong, could be the network, Try again later", exception: true)
                        
                    }
                    
                 }
      
       
    }
    
}