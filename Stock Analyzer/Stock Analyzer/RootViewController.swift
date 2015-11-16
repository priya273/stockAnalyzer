//
//  RootViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 10/31/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import CoreData
import UIKit


class RootViewController: UITabBarController
{
    
 var managedObjectContext: NSManagedObjectContext? = nil
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // 
        print("This is called");
    }
    
  
}
