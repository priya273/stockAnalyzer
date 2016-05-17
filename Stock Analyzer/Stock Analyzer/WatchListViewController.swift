//
//  WatchListViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 10/31/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import FBSDKCoreKit

class WatchListViewController: BaseTableViewController
{
    let tableViewCellIdentifier = "CellTableIdentifier";
    var name : NSString?
  
   
    @IBOutlet weak var userName: UIBarButtonItem!
    
    private var detailStockViewController:DetailStockViewController!

    private var IsVisible : Bool!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        name  = (UIApplication.sharedApplication().delegate as! AppDelegate).User!.name! as NSString
    
        if( name!.length > 8)
        {
            name = GetUserNameUpToLimitedCharaterOrFirstEmptySpace(name!)
        }
        
        IsVisible = true
        userName.title = "\(name!)"
        tableView.registerClass(StockTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier);
        let nib = UINib(nibName: "StockTableViewCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: tableViewCellIdentifier);
        tableView.tableFooterView = UIView()
        
        
    }
    
    func GetUserNameUpToLimitedCharaterOrFirstEmptySpace(name : NSString) -> NSString
    {
        let temp = name.componentsSeparatedByString(" ") as [NSString];
        if(temp[0].length > 8)
        {
           return name.substringToIndex(8)
            
        }
        else
        {
            return temp[0]
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        self.tabBarController?.tabBar.hidden = false;
        IsVisible = true
        //backgroundThread(3.0, background: GetLatestStockQuotes, completion: GetLatestStockQuotes)
               
        UpdateRealTimeQuotes()
    
    }
    
    func UpdateRealTimeQuotes() ->
        Void
    {
        backgroundThread(3.0, background: GetLatestStockQuotes, completion: UpdateRealTimeQuotes)

      if(IsVisible == true)
      {
        tableView.reloadData()
        print("-----visible-----")
      }
        
    }
    
    
    //Mark: - Data Source  Table view
    //The data source acts like a controller for table view
    //It provides information about the data

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellIdentifier) as! StockTableViewCell
        
        //cell.name = stock.valueForKey("name") as! String
        //cell.symbol = stock.valueForKey("symbol") as! String;
        configureCell(cell, atIndexPath: indexPath)

        return cell;
        
    }
    
    override func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath)
    {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Stock
        let cellCur = cell as! StockTableViewCell;
        
   
        cellCur.name = String(format:"%.2f",Double(object.lastPrice!))
        cellCur.change = Double(object.changePercent!)
        cellCur.symbol = object.symbol!
       
        
    }
   
    
    @IBAction func logout(sender: UIBarButtonItem)
    {
        //Do all saving
        
        FBSDKAccessToken.setCurrentAccessToken(nil)
        let facebookloginpage = self.storyboard?.instantiateViewControllerWithIdentifier("FaceBookLoginViewController") as! FaceBookLoginViewController
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.window?.rootViewController = facebookloginpage
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Stock;
        
        print("You selected \(object.name ) ")

        
        self.performSegueWithIdentifier("toDetailView", sender: object);
    }
    
   
        
    //Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
     
       if(segue.identifier == "toDetailView")
       {
          let stock = sender as! Stock;
          let destination = segue.destinationViewController as! DetailStockViewController
           destination.stock = stock;
        
       // self.tabBarController?.tabBar.hidden = true;
      }
        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
           IsVisible = false;
       
    }
    override func viewWillAppear(animated: Bool)
    {
         IsVisible = true;
       
        self.tableView.reloadData()
    }
    
    func reloadTable(watchcontroller : WatchListViewController)-> Void
    {
        watchcontroller.tableView.reloadData()
    }
    
    var GetLatestStockQuotes = 
    {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Stock", inManagedObjectContext: context)
        fetchRequest.entity = entity;
        
        do
        {
            let results = try context.executeFetchRequest(fetchRequest)
           
            if(results.count > 0)
            {
                let service = QuoteConsumer();
                
                
                for( var i = 0; i < results.count; i++)
                {
                    let stockEntity = results[i] as! Stock
                    service.GetStockPriceAndChange(stockEntity)
                    
                }
                print("------------\(NSThread.currentThread().valueForKeyPath("private.seqNum")!.integerValue)")
            
                //try context.save()
            }
        }
        catch
        {
            print("Failed to fetch / failed to save");
        }
        
        

    }
    
 
    
    
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil)
    {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0))
            {
            
            if(background != nil){ background!(); }
                
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
               
            }
        }
    }
    

}
