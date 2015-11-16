//
//  DetailStockViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 11/1/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class DetailStockViewController: UIViewController
{

    var stock : Stock!
    @IBOutlet weak var pageControlIcon: UIPageControl!
    
    var index = 0
        {
            didSet
            {
                if(index != oldValue)
                {
                    pageControlIcon.currentPage = index;
                }
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configurePageControlIcon();
        PageControlValueChanged();
        // Do any additional setup after loading the view.
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
    
    func configurePageControlIcon()
    {
        pageControlIcon.numberOfPages = 2;
    pageControlIcon.currentPage = index;
        pageControlIcon.pageIndicatorTintColor = UIColor.grayColor();
        pageControlIcon.currentPageIndicatorTintColor = UIColor.blackColor();
        pageControlIcon.addTarget(self, action: "PageControlValueChanged", forControlEvents: UIControlEvents.ValueChanged);
    }

    func PageControlValueChanged()
    {
   
        //Do something
        NSLog("The page control changed its current page to \(pageControlIcon.currentPage).");
       //http://samwize.com/2015/10/13/how-to-create-uipageviewcontroller-in-storyboard-in-container-view/
        
        
    }
    
  }
