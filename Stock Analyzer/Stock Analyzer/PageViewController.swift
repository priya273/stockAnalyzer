//
//  PageViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/2/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController , UIPageViewControllerDataSource
{

    //Instantiate view controllers
    var pages = [UIViewController]();

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.dataSource = self;
        
        let RealTimeStockChart : UIViewController = storyboard!.instantiateViewControllerWithIdentifier("RealTimeStockChart") as UIViewController;
        let SentimentalAnalysisChart: UIViewController = storyboard!.instantiateViewControllerWithIdentifier("SentimentalAnalysisChart") as UIViewController;
        pages.append(RealTimeStockChart);
        pages.append(SentimentalAnalysisChart);
        
        
        setViewControllers([RealTimeStockChart], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
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

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let currentVCIndex = pages.indexOf(viewController)!;
        let previousIndex = (abs(currentVCIndex - 1)) % pages.count;
    
        
        let vc = self.parentViewController as! DetailStockViewController;

        vc.index = previousIndex;
    
        
        return pages[previousIndex];
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let currentVCIndex = pages.indexOf(viewController)!;
        let nextVCIndex = (abs(currentVCIndex + 1)) % pages.count;
        let vc = self.parentViewController as! DetailStockViewController;
        vc.index = nextVCIndex;
   
        return pages[nextVCIndex];

    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return pages.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0;
    }
}
