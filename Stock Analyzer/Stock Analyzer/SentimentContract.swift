//
//  SentimentContract.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation


class SentimentContract
{
    var Symbol : String?
    
    var Dates : [String]!
    
    var Positive : [Double] = []
    
    var Negative: [Double] = []

    deinit
    {
        print("Disposed Sentiment Contract");
    }
}

