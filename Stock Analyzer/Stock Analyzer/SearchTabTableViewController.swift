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


class SearchTabTableViewController: BaseTableViewController, updateSearchResultProtocol,QuoteConsumerDelegate
{
    
    let DeleteStockTableCellIdentifier = "DeleteStockTableCell";
    
    //Create a searchview controller
    var searchViewController : UISearchController!;
    var userID: String!
    var context : NSManagedObjectContext?

    //Register the table view cell: DeleteStockTableCell to the table view class.
    //Since we using a customized cell, we need to indicate the table view, where it can find the
    //corresponding nib files. And also register the nib file with the table view.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID;
        context = self.fetchedResultsController.managedObjectContext
        
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
        tableView.tableFooterView = UIView()

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
         cellCur.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    
    func takeControl(searchState: String)
    {
        searchViewController.active = false;
        clearSearchBar(searchState)
    }
    
    
    func clearSearchBar(search : String)
    {
        
        let alertController = UIAlertController(title: search, message: "Unable to perform this operation right now." , preferredStyle: UIAlertControllerStyle.Alert)
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
            AddStockToWatchList(name, symbol: symbol)
        }
    }
    
    
    func AddStockToWatchList(name: String, symbol: String)
    {
        
        let service = QuoteConsumer()
        service.delegate = self;
        service.Run(symbol, id: nil)
    }
    
     // Mark :- QuoteSErvice Protocol
    func ServiceFailed(message: String)
    {
         self.alertTheUserSomethingWentWrong("Try again later", message: message, actionTitle: "okay")
    }
    
    
    func ServicePassed(contract: StockContract)
    {
        
        
        let entity2 = self.fetchedResultsController.fetchRequest.entity!
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity2.name!, inManagedObjectContext: self.context!) as! Stock
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        MapContractToModel(newManagedObject, contract: contract);
        
       
        // Save the context.
        do
        {
            try self.fetchedResultsController.managedObjectContext.save()
            let id = (UIApplication.sharedApplication().delegate as! AppDelegate).userID;
            let service = WatchListService()
            service.PutItemToWatchList(contract.symbol!, id: (id)!)
         } catch
         {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            
            //First save the symbol to the watch list.
            NSLog("There was a problem to insert");
            
            self.alertTheUserSomethingWentWrong("Try again later", message:"unable to add \(contract.symbol!) to your watch List ", actionTitle: "okay")
        }

        
        
    }
    
   // Mark :- Helper Functions
     func MapContractToModel(manangedObject: Stock, contract: StockContract)
     {
        manangedObject.change =  contract.change
        manangedObject.changePercent = contract.changePercent
        manangedObject.exchange = contract.exchange
        manangedObject.high = contract.high
        manangedObject.lastPrice = contract.lastPrice
        manangedObject.low = contract.low
        manangedObject.marketCap = contract.marketCap
        manangedObject.name = contract.name
         manangedObject.open = contract.open
         manangedObject.symbol = contract.symbol
         manangedObject.timestamp = contract.timestamp
        
         manangedObject.volumn = contract.volumn

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
            //abort()
            print("Unable to locate the managed Context, try again")
            
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
