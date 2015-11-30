//
//  Stock+CoreDataProperties.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/29/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stock {

    @NSManaged var change: NSNumber?
    @NSManaged var changePercent: NSNumber?
    @NSManaged var exchange: String?
    @NSManaged var high: NSNumber?
    @NSManaged var lastPrice: NSNumber?
    @NSManaged var low: NSNumber?
    @NSManaged var marketCap: NSNumber?
    @NSManaged var name: String?
    @NSManaged var open: NSNumber?
    @NSManaged var symbol: String?
    @NSManaged var timestamp: String?
    @NSManaged var stockDetail: NSManagedObject?

}
