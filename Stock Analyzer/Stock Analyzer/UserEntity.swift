//
//  UserEntity.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/14/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation

class UserEntity
{
    var id : String?
    var email : String?
    var name : String?
    init()
    {
        
    }
    
    init(id : String, name : String, email: String)
    {
        self.id = id;
        self.email = email
        self.name = name
    }
}