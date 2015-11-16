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
    
    func addItem(name: String, symbol: String)
    {
        insertNewObject(name, symbol: symbol)
        print("you selected \(name) and \(symbol)")
        self.searchViewController.active = false;
    }
    
    func insertNewObject(name: String, symbol: String)
    {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Stock
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
   
        
        newManagedObject.name = name;
        newManagedObject.symbol = symbol;
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true;
    }
    
  
}
