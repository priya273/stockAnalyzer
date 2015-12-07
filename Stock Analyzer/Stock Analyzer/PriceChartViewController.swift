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
    var stock : Stock!
    
    @IBOutlet weak var priceInformation: UILabel!
   // @IBOutlet weak var lineChartView: LineChartView!
   // var popUPView : PopUpView!
    var Positions : [Double] = []
    var Dates : [String] = []
    
    var prices : [Double] = []
    var dateComponentList : [NSDateComponents] = []
    var dataAvailable : Bool = false

    var lineChartView : LineChartView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //popUPView = PopUpView()
        
      
        DoAllNetworkCalls()
       
     
        
        print(months.count)
        print(dateComponentList.count)
        print(Positions.count)
        //print(value!.count)
       
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
                
                
            }
            catch
            {
                abort()
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

    //func setChart(dataPoints : [NSDateComponents], value: [Double] )
    //func setChart(dataPoints: [String], value: [Double])
    func setChart(dataPoints: [Double], value: [Double])
    {
        
        
        self.lineChartView = LineChartView()
        self.lineChartView.delegate = self
        
          lineChartView.noDataText = "You need to provide data for the chart."
        var dataEntriesYaxisForEachX :[ChartDataEntry] = []
        
        for (var i = 0; i < dataPoints.count; i++)
        {
     
            let dataEntry = ChartDataEntry(value: value[i], xIndex: i)
            dataEntriesYaxisForEachX.append(dataEntry)
        }
        
        let lineChartDateSet = LineChartDataSet(yVals: dataEntriesYaxisForEachX, label: "Price")
        lineChartDateSet.axisDependency = .Left
        lineChartDateSet.colors = [UIColor.blueColor()]
        lineChartDateSet.drawCirclesEnabled = false
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDateSet)
        
        
        
        lineChartView.data = lineChartData
    
        let minVal = value.minElement()!
        let maxVal = value.maxElement()!
        
        lineChartView.delegate = self
        
        lineChartView.backgroundColor =  UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)

        var intervalCount = Int(maxVal - minVal)
        
        
        lineChartView.leftAxis.customAxisMin = min(minVal - 5, lineChartView.data!.yMin - 1)
        
        
        lineChartView.leftAxis.customAxisMax = max(maxVal + 5, lineChartView.data!.yMax + 1)
        
        if(intervalCount / 10 != 0)
        {
            intervalCount = intervalCount / 10 + 1
        }
        //
//                print(intervalCount)
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
 
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight)
    {
        
        
          self.priceInformation.text = "\(self.months[self.dateComponentList[entry.xIndex].month - 1]) \(self.dateComponentList[entry.xIndex].day), \(self.dateComponentList[entry.xIndex].year)  Price : \(entry.value)"
        // let markerPosition = chartView.getMarkerPosition(entry: entry, highlight: highlight)
        //print(markerPosition.x)
        //  print(markerPosition.y)
        // print("Price : \(entry.value)")
        //print(Dates[entry.xIndex])
        // print(self.dateComponentList[entry.xIndex].month
        //popUPView!.label!.text = "\(self.months[self.dateComponentList[entry.xIndex].month - 1]) \(self.dateComponentList[entry.xIndex].day), \(self.dateComponentList[entry.xIndex].year)      Price : \(entry.value)"
        
      
       
        //popUPView.center = CGPointMake(110.0, 100.0)
       // lineChartView.addSubview(popUPView)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
