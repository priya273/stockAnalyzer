//
//  SearchTabTableViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/4/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//
import Foundation
import CoreData
import UIKit
import Alamofire

class SearchTabTableViewController: BaseTableViewController, updateSearchResultProtocol
{
    
    let DeleteStockTableCellIdentifier = "DeleteStockTableCell";
    
    //Create a searchview controller
    var searchViewController : UISearchController!;
    
    
    //Register the table view cell: DeleteStockTableCell to the table view class.
    //Since we using a customized cell, we need to indicate the table view, where it can find the
    //corresponding nib files. And also register the nib file with the table view.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureTableView();
        
        //For searching items
        setUpSearchController();
        
        navigationItem.rightBarButtonItem = editButtonItem();
    }
 
    
    private func configureTableView()
    {
        
        //Register Table view cell
        tableView.registerClass(DeleteStockTableCell.self, forCellReuseIdentifier: DeleteStockTableCellIdentifier);
        
        //tell the table view where to find correspoindoing nib file
        let nib = UINib(nibName: "DeleteStockTableCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: DeleteStockTableCellIdentifier);

    }
    
    
    private func setUpSearchController()
    {
        let updateSearchResultController = UpdateSearchResultController();
        updateSearchResultController.delegate = self;
       
        self.searchViewController = UISearchController(searchResultsController: updateSearchResultController);
        
        //Set up searchBar
        let searchBar = self.searchViewController.searchBar;
        searchBar.placeholder = "Enter a search term";
        searchBar.scopeButtonTitles = ["Ticker", "Company Name"];
        searchBar.sizeToFit();
        
        //configure the table view header with the search bar
        self.tableView.tableHeaderView = searchBar;
        self.searchViewController.searchResultsUpdater = updateSearchResultController;
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(DeleteStockTableCellIdentifier, forIndexPath: indexPath) as! DeleteStockTableCell;
        
        
        // Configure the cell...
       
        configureCell(cell, atIndexPath: indexPath)
       
        return cell
    }

    
    override func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath)
    {
         let stock = self.fetchedResultsController.objectAtIndexPath(indexPath);
         let cellCur = cell as! DeleteStockTableCell
        
         cellCur.name = stock.valueForKey("name") as! String
         cellCur.symbol = stock.valueForKey("symbol") as! String;
    }
    
    func takeControl(searchState: String)
    {
        searchViewController.active = false;
        clearSearchBar(searchState)
    }
    func clearSearchBar(search : String)
    {
        
        let alertController = UIAlertController(title: search, message: "Can not find " + search, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

      func addItem(name: String, symbol: String)
    {
        self.searchViewController.active = false;
        print("you selected \(name) and \(symbol)")
        insertNewObject(name, symbol: symbol)
        
    }
    
    func insertNewObject(name: String, symbol: String)
    {
        if(CheckIfTheSymbolAlreadyExist(symbol))
        {
            return;
        }

        else
        {
            //Add new symbol
            AddNewStockToWatchList(name, symbol: symbol)
        }
    }
    
    func AddNewStockToWatchList(name: String, symbol: String)
    {
        let context = self.fetchedResultsController.managedObjectContext
        let entity2 = self.fetchedResultsController.fetchRequest.entity!
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity2.name!, inManagedObjectContext: context) as! Stock
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        
        
        newManagedObject.name = name;
        newManagedObject.symbol = symbol;
        
        setAllVariables(newManagedObject)
        
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
           
            
            //First save the symbol to the watch list.
            NSLog("There was a problem to insert");
            
            self.alertTheUserSomethingWentWrong("Try again later", message:"unable to add \(newManagedObject.symbol!) to your watch List", actionTitle: "okay")
        }
        
    }
    
    func setAllVariables(object : Stock)
    {
        
        Alamofire.request(.GET, "http://dev.markitondemand.com/Api/v2/Quote/json?", parameters: ["symbol" : object.symbol!]).responseJSON {
            JSON in
            do
            {
                let values = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                
                object.open =  values.valueForKey("Open") as? NSNumber
                object.high = values.valueForKey("High") as? NSNumber
                object.low =  values.valueForKey("Low") as? NSNumber
                object.marketCap = values.valueForKey("MarketCap") as? NSNumber
                
                object.lastPrice = values.valueForKey("LastPrice") as? NSNumber
                
                object.volumn = values.valueForKey("Volume") as? NSNumber
                object.change = values.valueForKey("Change") as? NSNumber
                object.changePercent = values.valueForKey("ChangePercent") as? NSNumber
                
                
                
                // Save the context.
                do {
                    try self.fetchedResultsController.managedObjectContext.save()
                   }
                   catch
                   {
                   
                    NSLog("There was a problem to insert");
                    
                    self.alertTheUserSomethingWentWrong("TO DO", message:"Couldnt update other fields to \(object.symbol!)", actionTitle: "okay")

                    
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                   // abort()
                }
            }
            catch
            {
               
                
                self.alertTheUserSomethingWentWrong("You Selected \(object.symbol!)", message: "something went wrong, could be the network", actionTitle: "okay")
               
//                let controller = UIAlertController(title: "You Selected \(object.symbol!)", message: "something went wrong try again", preferredStyle: UIAlertControllerStyle.Alert)
//                let action = UIAlertAction(title: "okay", style: UIAlertActionStyle.Cancel, handler: nil)
//                controller.addAction(action)
//                
//                self.presentViewController(controller, animated: true, completion: nil)
            }
            
            
        }

    }
    func CheckIfTheSymbolAlreadyExist(symbol : String) -> Bool
    {
     
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let predicate = NSPredicate(format: "symbol == '\(symbol)'", argumentArray: nil)
        let entity = NSEntityDescription.entityForName("Stock", inManagedObjectContext: self.fetchedResultsController.managedObjectContext)
        
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        do
        {
            let objectFetch = try self.fetchedResultsController.managedObjectContext.executeFetchRequest(fetchRequest) as! [Stock]
            if(objectFetch.count > 0)
            {
                //print("Already Exist")
                
                self.alertTheUserSomethingWentWrong( "You Selected \(symbol)", message: "Looks like this symbol already exists in your watch List!", actionTitle: "yey, I do")
                
                return true;
            }
            
        }
        catch
        {
            abort()
        }
        
        return false;
    }
    
    // MARK :- Table view
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true;
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            do {
                try context.save()
            } catch {
                NSLog("There was a problem in delete");
                 self.alertTheUserSomethingWentWrong("Try again later", message:"unable to delete to your watch List", actionTitle: "okay")
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                //abort()
            }
        }
    }

   // Mark :- Alert Controller
    func alertTheUserSomethingWentWrong(titleforController: String, message : String, actionTitle: String)
    {
        let controller = UIAlertController(title: titleforController , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Cancel, handler: nil)
        controller.addAction(action)
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
}
