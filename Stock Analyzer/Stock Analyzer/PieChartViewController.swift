//
//  PieChartViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 12/2/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import Charts
class PieChartViewController: UIViewController, SentimentConsumerDelegate
{

    @IBOutlet weak var pieChartView: PieChartView!
      var sentiments : SentimentContract?
    var stock : Stock!
    var parentcontroller : ChartTabViewController?
    var SentimentValues = ["Positive","Negative"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

       
        parentcontroller = (self.parentViewController as! ChartTabViewController)
        self.stock = parentcontroller!.stock
        
        self.sentiments = parentcontroller!.sentiments
        
       
        
        if(self.sentiments == nil)
        {
            CallService()
        }
        else
        {
           
            ShowCharts()
        }
        
        
        // Do any additional setup after loading the view.
    }
    func CallService()
    {
        let service = SentimentConsumer()
        service.delegate = self;
        service.Run(self.stock.symbol!, id: nil)
    }

    func ShowCharts()
    {
        
       // let averageSentiments = [56.92, 43.08]
        
         let averageSentiments = ComputeAverageSentiments()

        
        setCharts(SentimentValues, values: averageSentiments)
    }
    
    func ComputeAverageSentiments() -> [Double]
    {
        var totalPositive = 0.0;
        var totalNegaitve = 0.0
        let count = self.sentiments!.Positive.count
        for(var i = 1; i < count ; i++)
        {
            totalPositive += self.sentiments!.Positive[i]
            totalNegaitve += self.sentiments!.Negative[i]
        }
        
       /*if(count > 0)
       {
        totalNegaitve = GetAverage(totalNegaitve, count: count)
        totalPositive = GetAverage(totalPositive, count: count)
       }
        
       
        */
        
        let ratioOFPositiveScore = (totalPositive / (totalPositive + totalNegaitve) * 100)
        
        let ratioOfNegativeScore = (totalNegaitve / (totalNegaitve + totalPositive) * 100)
        
        return [ ratioOFPositiveScore, ratioOfNegativeScore ]
        
    }
    
    func GetAverage( val : Double, count : Int) -> Double
    {
        if(val == 0 || count == 0)
        {
            return 0
        }
      
        let result = val / Double(count)
        return result;
    }
    
    override func didReceiveMemoryWarning()
    {
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
        pieChartView.descriptionText = "Cummulative ratio of Positive over Negative Sentiments"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func ServiceFailed(message: String)
    {
        
        self.pieChartView!.noDataText = "No Data available to load";
    }
    
    func ServicePassed(sentiment: SentimentContract)
    {
        self.sentiments = sentiment;
        self.parentcontroller?.sentiments = self.sentiments
        
        ShowCharts()
    }


}
