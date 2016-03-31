//
//  SentimentalChartViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/30/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Charts

class SentimentalChartViewController: UIViewController, SentimentConsumerDelegate
{

  
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var val: UILabel!
    var size = 6
    var date : [String]!
    
    var sentiments : SentimentModel?
    var stock : Stock!
    
    var parentcontroller : ChartTabViewController?
  
    var contract : SentimentContract?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        self.barChartView.noDataText = "No Data Available";
        parentcontroller = (self.parentViewController as! ChartTabViewController)
        self.stock = parentcontroller!.stock

        self.contract = parentcontroller!.sentiments
        
      
        CallService()
       
        // Do any additional setup after loading the view.
        
        //staticMethod()
       
        
        barChartView.backgroundColor =  UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
    }
    
    func staticMethod()
    {
        date = ["Mar 16","Mar 17"]
        let p: [Double] = [436, 106]
        let n : [Double] = [583, 167]
        
        let model = SentimentModel()
        
        for(var i = 0; i < date.count; i++)
        {
            model.Dates.append(date[i])
             model.Positive.append(p[i])
             model.Negative.append(n[i])
        }
        
        
        setChart(self.date, valOne: model.Positive, valTwo: model.Negative)
    }
    
    func CallService()
    {
        let service = SentimentConsumer()
        service.delegate = self;
        service.Run(stock.symbol!, id: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  ShowChart()
    {
        
         setChart(self.sentiments!.Dates, valOne: self.sentiments!.Positive, valTwo: self.sentiments!.Negative)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: -Charts
    
    
    
    func setChart(dataPoints: [String], valOne: [Double], valTwo: [Double])
    {
     
        var dataEntriesOne : [BarChartDataEntry] = []
        var dataEntriesTwo : [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntryOne = BarChartDataEntry(value: valOne[i], xIndex: i)
            let dataEntryTwo = BarChartDataEntry(value: valTwo[i], xIndex: i)

            dataEntriesOne.append(dataEntryOne)
            dataEntriesTwo.append(dataEntryTwo)
        }
        
        //Describe what the y values are with the object chardataset
        let yValuesDataSetOne = BarChartDataSet(yVals: dataEntriesOne, label: "Positive sentiments")
              yValuesDataSetOne.colors = [UIColor.greenColor()]
        
        let yValuesDataSetTwo = BarChartDataSet(yVals: dataEntriesTwo, label: "Negative sentiments")
        
        yValuesDataSetTwo.colors = [UIColor.redColor()]
        
        let dataSet = [yValuesDataSetOne, yValuesDataSetTwo]
        
        //let xValuesWithCorrespondingYValuesData = BarChartData(xVals: date, dataSet: yValuesDataSetOne)
        let xValuesWithCorrespondingYValuesData = BarChartData(xVals: date, dataSets: dataSet)
        
        //Set it to the barchart view object
        
        barChartView.data = xValuesWithCorrespondingYValuesData
        
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .Bottom
        //barChartView.draw
    
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        barChartView.scaleYEnabled = false
        barChartView.scaleXEnabled = false
    }
    
    
    func ServiceFailed(message: String)
    {
        self.barChartView.noDataText = message;
    }
    
    func ServicePassed(sentiment: SentimentContract)
    {
       
        self.parentcontroller?.sentiments = sentiment
        self.contract = sentiment;
        
        self.date = sentiment.Dates
        
         setChart(date, valOne: sentiment.Positive, valTwo: sentiment.Negative)

    }

    
}
