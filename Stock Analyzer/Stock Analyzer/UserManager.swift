//
//  UserManager.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/14/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import CoreData
import Foundation
import UIKit

protocol UserExistDelegate
{
    func UserExistsOrCreated()
    func UnableToRetriveOrCreateUser()
}

class UserManager : UserCreationDelegate
{
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var delegate : UserExistDelegate?
    
    init()
    {
     
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        self.managedObjectContext = appDel.managedObjectContext;
        
    }
    
    func ValidateUser(user : UserEntity)
    {
       PersistUserLocally(user)
       PersistUserRemotely(user)
    }
    
    
    func PersistUserLocally(user : UserEntity)
    {
        (UIApplication.sharedApplication().delegate as! AppDelegate).userID = user.id;
        (UIApplication.sharedApplication().delegate as! AppDelegate).User = user;
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let predicate = NSPredicate(format: "id == '\(user.id)'", argumentArray: nil)
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: self.managedObjectContext!)
        
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        do
        {
            let objectFetch = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as! [User]
            if(objectFetch.count > 0)
            {
                print("Already Exist")
               
            }
            else
            {
                AddUserLocally(user)
               
            }
            
        }
        catch
        {
            print("Unable to locate the managed Context, try again")
            self.delegate?.UnableToRetriveOrCreateUser()
       
        }
        
    }
  
    
    
    func PersistUserRemotely(userEntity : UserEntity)
    {
        let userContract = UserContract();
        userContract.id = userEntity.id;
        userContract.Email = userEntity.email
        
        let service = UserProvider();
        service.Delegate = self
        //add to presistent data and call
        service.PostNewUserRecord(userContract)
        
    }
    
    func AddUserLocally(userEntity : UserEntity)
    {
        let userManagedObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext!) as! User
        
        userManagedObject.id = userEntity.id
        
        userManagedObject.isActiveRemotely = 1
        userManagedObject.email = userEntity.email
        userManagedObject.name = userEntity.name

        do{
            try managedObjectContext?.save()
            (UIApplication.sharedApplication().delegate as! AppDelegate).userID = userEntity.id;
        
        }
        catch
        {
            NSLog("There was a problem to add New USer");
            self.delegate?.UnableToRetriveOrCreateUser()
        }
        
    }
    
    
    func UserCreationSuccess()
    {
        self.delegate?.UserExistsOrCreated()
    }
    
    func UserCreationFailed()
    {
        self.delegate?.UnableToRetriveOrCreateUser()
    }
    
    func GetUserEntity(id : String) -> Bool
    {
      
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let predicate = NSPredicate(format: "id == '\(id)'", argumentArray: nil)
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: self.managedObjectContext!)
        
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        do
        {
            let objectFetch = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as! [User]
            if(objectFetch.count > 0)
            {
                print("Already Exist")
            
                let user = UserEntity()
                user.id = objectFetch[0].id;
                user.name = objectFetch[0].name
                (UIApplication.sharedApplication().delegate as! AppDelegate).User = user
                (UIApplication.sharedApplication().delegate as! AppDelegate).userID = objectFetch[0].id;
                
                
                return true;
                
            }
            else if(objectFetch.count == 0)
            {
                return false;
            }
            
        }
        catch
        {
            print("Unable to locate the managed Context, try again")
           
        }
        
        return false
    }
    
}
