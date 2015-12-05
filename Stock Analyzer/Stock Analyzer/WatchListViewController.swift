//
//  WatchListViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 10/31/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import CoreData

class WatchListViewController: BaseTableViewController
{
   let tableViewCellIdentifier = "CellTableIdentifier";
    
    private var detailStockViewController:DetailStockViewController!



    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.registerClass(StockTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier);
        let nib = UINib(nibName: "StockTableViewCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: tableViewCellIdentifier);
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        self.tabBarController?.tabBar.hidden = false;
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
        
        cellCur.name = object.name!
        cellCur.symbol = object.symbol!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Stock;
        
        print("You selected \(object.name ) ")

        self.performSegueWithIdentifier("toDetailView", sender: object);
    }
    
   
    

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return 1;
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return 0;
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if(detailStockViewController?.view.superview == nil)
        {
            detailStockViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailStockViewController") as! DetailStockViewController;
        }
        
       // self.presentViewController(detailStockViewController, animated: true, completion: nil);
        
        
    }*/
    
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
    
}
