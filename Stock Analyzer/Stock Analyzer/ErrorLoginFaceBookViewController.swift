//
//  ErrorLoginFaceBookViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 3/16/16.
//  Copyright © 2016 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit


class ErrorLoginFaceBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.alertTheUserSomethingWentWrong("Try again", message:"Something went Wrong", actionTitle: "okay")
        ShowFaceBookLogin()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark :- Alert Controller
    func alertTheUserSomethingWentWrong(titleforController: String, message : String, actionTitle: String)
    {
        let controller = UIAlertController(title: titleforController , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Cancel, handler: nil)
        controller.addAction(action)
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    func ShowFaceBookLogin()
    {
        FBSDKAccessToken.setCurrentAccessToken(nil)
        let facebookloginpage = self.storyboard?.instantiateViewControllerWithIdentifier("FaceBookLoginViewController") as! FaceBookLoginViewController
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.window?.rootViewController = facebookloginpage
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
