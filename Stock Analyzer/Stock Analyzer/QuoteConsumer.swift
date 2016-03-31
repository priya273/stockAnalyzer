//
//  QuoteConsumer.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation
import Alamofire

protocol QuoteConsumerDelegate
{
    func ServiceFailed(message: String)
    func ServicePassed(stock: StockContract)
 
}


class QuoteConsumer
{
    var delegate : QuoteConsumerDelegate!
    
    func Run(symbol : String, id : String?)
    {
        
        let url = NSURL(string: "http://stockanalyzer.azurewebsites.net/api/stock/quote/\(symbol)");
        
        let headers = ["id" : "\(id)"]
        
        Alamofire.request(.GET, url!, parameters: headers).responseJSON
            {
                JSON in
                do
                {
                    let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                    
                    let object = StockContract();
                    object.name =  values.valueForKey("Name") as? String
                    object.symbol = values.valueForKey("Symbol") as? String
                    object.open =  values.valueForKey("Open") as? NSNumber
                    object.high = values.valueForKey("High") as? NSNumber
                    object.low =  values.valueForKey("Low") as? NSNumber
                    object.marketCap = values.valueForKey("MarketCap") as? NSNumber
                    
                    object.lastPrice = values.valueForKey("LastPrice") as? NSNumber
                    
                    object.volumn = values.valueForKey("Volume") as? NSNumber
                    object.change = values.valueForKey("Change") as? NSNumber
                    object.changePercent = values.valueForKey("ChangePercent") as? NSNumber
                    self.delegate?.ServicePassed(object)
                    
                }
                catch
                {
                    
                    self.delegate?.ServiceFailed("Failed to Load Quote from service for Symbol: \(symbol)")
                }
                
                
        }
    }
    
    func GetStockPriceAndChange(object: Stock)
    {
         let symbol = "\(object.symbol!)" as String;
        print("Finding price for \(symbol)")
       
        let url = NSURL(string: "http://stockanalyzer.azurewebsites.net/api/stock/quote/\(symbol)");
        
        //let headers = ["id" : "\(id)"] Alamofire.request(.GET, url!, parameters: headers).responseJSON
        
        Alamofire.request(.GET, url!, parameters: nil).responseJSON
            {
                JSON in
                do
                {
                    let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                    object.setValue(values.valueForKey("LastPrice") as? NSNumber, forKey: "lastPrice")
                    object.setValue(values.valueForKey("ChangePercent") as? NSNumber, forKey: "changePercent")
                  
                    
                }
                catch
                {
                        print("Failed To reload Price and change information")
                    
                }
                
                
        }

        
        
    }
}
