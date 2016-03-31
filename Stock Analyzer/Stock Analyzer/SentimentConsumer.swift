//
//  SentimentConsumer.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//


import Foundation
import Alamofire

protocol SentimentConsumerDelegate
{
    func ServiceFailed(message: String)
    func ServicePassed(sentiment: SentimentContract)
}

class SentimentConsumer
{
    var delegate: SentimentConsumerDelegate!
    
    func Run(symbol : String, id : String?)
    {
        let url = NSURL(string: "http://stockanalyzer.azurewebsites.net/api/sentiment/\(symbol)");
        
        let headers = ["id" : "\(id)"]
        
        Alamofire.request(.GET, url!, parameters: headers).responseJSON
            {
                JSON in
                do
                {
                    let serialization = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                   
                    
                    let message = try serialization.valueForKey("Message") as? String
                    
                    if(message  == nil)
                    {
                        let sentiment = SentimentContract()
                        
                        sentiment.Dates =   serialization.valueForKey("Dates") as! [String]
                        
                        sentiment.Positive = serialization.valueForKey("PositiveScore") as! [Double]
                        
                        sentiment.Symbol = serialization.valueForKey("") as? String
                        
                        sentiment.Negative = serialization.valueForKey("NegativeScore") as! [Double]
                        
                        self.delegate?.ServicePassed(sentiment)

                    }
                    else
                    {
                            self.delegate?.ServiceFailed("No data availabe to load");
                    }
                    
                }
                catch
                {
                     self.delegate?.ServiceFailed("No data availabe to load");
                    
                }
                
          }
        
     }
}