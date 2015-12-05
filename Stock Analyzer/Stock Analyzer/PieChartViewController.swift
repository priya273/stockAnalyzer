//
//  PieChartViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 12/2/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Charts
class PieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let sentiments = ["Positive","Negative"]
        let averageSentiments = [56.92, 43.08]
        
        setCharts(sentiments, values: averageSentiments)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark:
    func setCharts(dataPoints: [String], values: [Double])
    {
         var dataEntries: [ChartDataEntry] = []
        
        //Set the y values that ploted against x
         for i in 0..<dataPoints.count
         {
                let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            
            dataEntries.append(dataEntry)
         }
        
        //Provide a label to the y entries by declaring a chart data set
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Sentiments")
        
        
        let colors = [UIColor.greenColor(), UIColor.redColor()]
        
        pieChartDataSet.colors = colors
        //we need to provide corresponding x values for the y dataset and this is done by using a different object
        // called the Chart Data object
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        pieChartView.data = pieChartData
        pieChartView.descriptionText = "Average Sentiments over the last 6 days"
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
