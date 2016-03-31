//
//  UserTrackServices.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/14/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


protocol UserCreationDelegate
{
    func UserCreationSuccess()
    func UserCreationFailed()
}

class UserProvider
{
    let UserStatusCodeAlreadyExists = 200;
    let UserCreatedStatusCode = 201
    let BadRequest = 400
    
    var Delegate : UserCreationDelegate!
    
    func PostNewUserRecord(user : UserContract)
    {
        let url = NSURL(string: "http://stockanalyzer.azurewebsites.net/api/user");
        
        let req = NSMutableURLRequest(URL : url!)
        
        req.HTTPMethod = "POST"
        
        
        
        let dict: [String : String] = [ "id" : user.id!,
            "Email": user.Email!
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
                
                
                print(Response.response?.statusCode);
                
                if(Response.response?.statusCode == 400 || Response.response?.statusCode == 500)
                {
                     self.Delegate?.UserCreationFailed()
                }
                else
                {
                   self.Delegate?.UserCreationSuccess()
                }
                
        }
        
    }
    
}