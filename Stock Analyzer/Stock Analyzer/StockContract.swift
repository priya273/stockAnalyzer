//
//  StockContract.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation


class StockContract
{
     var change: NSNumber?
     var changePercent: NSNumber?
     var exchange: String?
     var high: NSNumber?
     var lastPrice: NSNumber?
     var low: NSNumber?
     var marketCap: NSNumber?
     var name: String?
     var open: NSNumber?
     var symbol: String?
     var timestamp: String?
    
     var volumn: NSNumber?
    
    init()
    {
        print("Created Stock contract");
    }
    deinit
    {
        print("Disposed Stock contract");
    }
}