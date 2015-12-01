//
//  SentimentalChartViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/30/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Charts

class SentimentalChartViewController: UIViewController
{

  
    @IBOutlet weak var barChartView: BarChartView!
    
    var date : [String]!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        date = ["1 Jan","2 Jan","3 Jan","4 Jan","5 Jan","6 Jan"]
        let positiveResponse = [50.9, 55.8, 60.8, 49.0, 45.0, 80.0]
        
        setCharts(date, values: positiveResponse)
        
    }
    
    override func didReceiveMemoryWarning() {
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

    
    //MARK: -Charts
    func setCharts(dataPoints : [String], values : [Double])
    {
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        //Describe what the y values are with the object chardataset
        let yValuesDataSet = BarChartDataSet(yVals: dataEntries, label: "Positive sentiments")
        let xValuesWithCorrespondingYValuesData = BarChartData(xVals: date, dataSet: yValuesDataSet)
        yValuesDataSet.colors = [UIColor.greenColor()]
    
        //Set it to the barchart view object
        
        barChartView.data = xValuesWithCorrespondingYValuesData
    
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.backgroundColor = UIColor.grayColor()
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
    }

}
