//
//  Stock+CoreDataProperties.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/15/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stock {

    @NSManaged var exchange: String?
    @NSManaged var name: String?
    @NSManaged var symbol: String?
    @NSManaged var stockDetail: NSManagedObject?

}
