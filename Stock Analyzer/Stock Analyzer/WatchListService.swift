//
//  StockService.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation
import Alamofire

class WatchListService
{
    
    func PutItemToWatchList(symbol : String, id : String)
    {
        if(id.isEmpty)
        {
            print("Id is nill or empty");
        }
        else
        {
            let url = NSURL(string: "http://stockanalyzer.azurewebsites.net/api/user/watchlist/\(id)");
            
            let req = NSMutableURLRequest(URL : url!)
            
            req.HTTPMethod = "PUT"
            
            
            
            let dict: [String : String] = [
                "Ticker": symbol
            ]
            
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            do
            {
                req.HTTPBody = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
            }
            catch
            {
                print("Exception Converting to jason.")
            }
            
            
            Alamofire.request(req).responseJSON
                {
                    Response in
                    
                    if(Response.response?.statusCode == 200 || Response.response?.statusCode == 201 || Response.response?.statusCode == 202)
                    {
                        print("Services:----- Successfully Added a symbol to my Watchlist")
                    }
                    else
                    {
                        print ("Service:----- Failed to Add Stock Symbol to WatchList")
                    }
            }
        }

        
    }
    
    func DeleteItemFromWatchList(symbol: String, id: String)
    {
        
    }

}
