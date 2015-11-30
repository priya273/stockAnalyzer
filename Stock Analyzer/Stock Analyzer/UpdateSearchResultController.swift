//
//  UpdateSearchResultController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/4/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

protocol updateSearchResultProtocol
{
    func addItem(name: String, symbol: String)
    func takeControl(searchState: String)
}

class UpdateSearchResultController: UITableViewController, AddStockTableCellDelegate, UISearchResultsUpdating
{
    var searchItems : NSArray!
    //var allResults : [String] = [];
    
    let AddStockTableCellIdentifier = "AddStockTableCell";
     var filteredTickerSymbols : [String] = [];
    let tickerButtonPressed : Int = 0;
    let nameButtonPressed :Int = 1;
    var selectedType = -1;
    let searchType = ["Symbol", "Name"];

  
    var delegate : updateSearchResultProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Register Table view cell
        tableView.registerClass(AddStockTableCell.self, forCellReuseIdentifier: AddStockTableCellIdentifier);
        
        //tell the table view where to find correspoindoing nib file
        let nib = UINib(nibName: "AddStockTableCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: AddStockTableCellIdentifier);
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
     
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

 override    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        if(filteredTickerSymbols.isEmpty)
        {
            return 0
        }
        
        return filteredTickerSymbols.count
     
    }


   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
    
        let cell = tableView.dequeueReusableCellWithIdentifier(AddStockTableCellIdentifier, forIndexPath: indexPath) as! AddStockTableCell;
        
        
        // Configure the cell...

            cell.symbolOrName = filteredTickerSymbols[indexPath.row];
            cell.delegate = self;

        
        
        return cell
    }
    
    //MARK :- AddButton Protocal
    func addButtonTapped(cell: AddStockTableCell)
    {
        
        let indexPath = self.tableView.indexPathForCell(cell);
        let selectedSTock = filteredTickerSymbols[indexPath!.row];
        

        for item in self.searchItems
        {
            let itemCur = item as! NSDictionary
            
            if((itemCur.valueForKey(searchType[selectedType]) as! String) == selectedSTock)
            {
                
                
                delegate?.addItem(itemCur.valueForKey("Name") as! String, symbol: itemCur.valueForKey("Symbol") as! String)
             
                break;
            }
        }
    }

    //MARK :- Updating search controller
    
        
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let search = searchController.searchBar.text?.uppercaseString;
        
        
        selectedType = searchController.searchBar.selectedScopeButtonIndex;
      
        //Remove everything that is in the filterred array
        filteredTickerSymbols.removeAll();
        
            if(!search!.isEmpty)
        {

        
            Alamofire.request(.GET, "http://dev.markitondemand.com/Api/v2/Lookup/json?", parameters: ["input" : search!]).responseJSON {
            JSON in
            
                let data = JSON.data! as NSData;
               //print(JSON)
                do
                {
                
                 self.searchItems = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray;
                
                    let allResults = self.searchItems.valueForKey(self.searchType[self.selectedType]) as! [String];
                    
                    if(!search!.isEmpty && allResults.count > 0)
                    {
                        self.updateFilteredList(allResults, search: search!);
                    }
                }
                catch
                {
                   // abort()
                    print("Something went wrong")
                    //self.filteredTickerSymbols.removeAll()
                    self.delegate?.takeControl(search!)
                    
                    
                    //self.clearSearchBar()
                    
                    
                }
            }
    
        }
  
               tableView.reloadData();
    }

    

    func updateFilteredList(allResults: [String], search : String)
    {
        
        for key in allResults
        {
            if(key.rangeOfString(search.uppercaseString) != nil || key.rangeOfString(search.lowercaseString) != nil)
            {
                filteredTickerSymbols.append(key);
            }
        }

              tableView.reloadData();
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
