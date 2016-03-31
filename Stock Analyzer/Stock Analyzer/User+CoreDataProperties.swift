//
//  User+CoreDataProperties.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/14/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation
import CoreData

extension User
{
    @NSManaged var id: String?
    @NSManaged var isActiveRemotely: NSNumber?
    @NSManaged var name: String?
    @NSManaged var email: String?
}

