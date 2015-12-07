//
//  PriceChartViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/30/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Charts

import Alamofire
import Foundation
class PriceChartViewController: UIViewController, ChartViewDelegate

{
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]

    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var priceInformation: UILabel!
    var stock : Stock!

    var Positions : [Double] = []
    var Dates : [String] = []
    
    var prices : [Double] = []
    var dateComponentList : [NSDateComponents] = []
    var dataAvailable : Bool = false

    var lineChartView : LineChartView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DoAllNetworkCalls()

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func DoAllNetworkCalls()
    {
        let parentVC = self.parentViewController as! ChartTabViewController
        self.stock = parentVC.stock
        
        print("Printing before view load")
        print(stock.symbol!)
        
        let params = "{\"Normalized\":false,\"NumberOfDays\":365,\"DataPeriod\":\"Day\",\"Elements\":[{\"Symbol\":\"\(stock.symbol!)\",\"Type\":\"price\",\"Params\":[\"c\"]}]}"
        //let escapedParams = params.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        Alamofire.request(.GET, "http://dev.markitondemand.com/Api/v2/InteractiveChart/json", parameters: ["parameters" : params]).responseJSON {
            JSON in
            //  print(JSON)
            do
            {
                let serialization = try NSJSONSerialization.JSONObjectWithData(JSON.data! as NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
                
                if(serialization.valueForKey("Elements")?.count > 0)
                {
                    self.dataAvailable = true
                    self.Positions = serialization.valueForKey("Positions") as! [Double]
                    self.Dates = serialization.valueForKey("Dates") as! [String]
                    
                    self.setDateComponent()
                    
                    let value = (((serialization.valueForKey("Elements") as! NSArray).valueForKey("DataSeries") as! NSArray ).valueForKey("close") as! NSArray).valueForKey("values") as! NSArray
                    self.prices = value[0] as! [Double]
                    
                    self.setChart(self.Positions, value: self.prices)
                }
                else
                {
                    self.priceInformation.text = "No data availabel to load"
                }
            }
            catch
            {
                 self.alertTheUserSomethingWentWrong("Problem loading graph", message: "something went wrong, could be the network", actionTitle: "okay")
            }
        }

    }
    
    
    func setDateComponent()
    {
        let dateFormatter = NSDateFormatter()
        //dateFormatter.locale = NSLocale(localeIdentifier: "")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let calender = NSCalendar.currentCalendar()
               for( var i = 0; i < Dates.count; i++)
        {
            
            if let date : NSDate = dateFormatter.dateFromString(Dates[i])!
            {
                let dateComponent : NSDateComponents = calender.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: date)
                
                dateComponentList.append(dateComponent)
            }
            
        }
        
    }

    func setChart(dataPoints: [Double], value: [Double])
    {

        self.lineChartView = LineChartView()
        self.lineChartView.delegate = self
        
        self.lineChartView.noDataText = "You need to provide data for the chart."
        
        self.lineChartView.backgroundColor =  UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        var dataEntriesYaxisForEachX :[ChartDataEntry] = []
        
        for (var i = 0; i < dataPoints.count; i++)
        {
     
            let dataEntry = ChartDataEntry(value: value[i], xIndex: i)
            dataEntriesYaxisForEachX.append(dataEntry)
        }
        
        let lineChartDateSet = LineChartDataSet(yVals: dataEntriesYaxisForEachX, label: "Price for the last one year")
        lineChartDateSet.axisDependency = .Left
        lineChartDateSet.colors = [UIColor.blueColor()]
        lineChartDateSet.drawCirclesEnabled = false
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDateSet)
        
        
        
        self.lineChartView.data = lineChartData
    
        let minVal = value.minElement()!
        let maxVal = value.maxElement()!
       

        var intervalCount = Int(maxVal - minVal)
        
        
        lineChartView.leftAxis.customAxisMin = min(minVal - 2, lineChartView.data!.yMin - 1)
        
        
        lineChartView.leftAxis.customAxisMax = max(maxVal + 2, lineChartView.data!.yMax + 1)
        
        if(intervalCount / 5 != 0 && intervalCount / 5 > 2)
        {
            intervalCount = intervalCount / 5
        }
       
        lineChartView.leftAxis.labelCount = intervalCount
        lineChartView.leftAxis.startAtZeroEnabled = false
        
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.descriptionText = ""
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.xAxis.gridColor =  UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        lineChartView.leftAxis.gridColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
       // lineChartView.drawGridBackgroundEnabled = false
 
       lineChartView.frame = CGRectMake(0, 0, self.chartView.frame.width, self.chartView.frame.height)
     
        self.chartView.addSubview(self.lineChartView)
        self.priceInformation.text = "Interactive Chart"
 
        
    }
    
    

    
     // MARK: - ChartViewDelegate
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight)
    {
        
          self.priceInformation.text = "\(self.months[self.dateComponentList[entry.xIndex].month - 1]) \(self.dateComponentList[entry.xIndex].day), \(self.dateComponentList[entry.xIndex].year)  Price : \(entry.value)"
    }
    
    // MARK: - Alert Controller
    func alertTheUserSomethingWentWrong(titleforController: String, message : String, actionTitle: String)
    {
        let controller = UIAlertController(title: titleforController , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Cancel, handler: nil)
        controller.addAction(action)
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }

}
