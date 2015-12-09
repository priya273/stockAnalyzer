//
//  FaceBookLoginViewController.swift
//  Stock Analyzer
//
//  Created by Naga sarath Thodime on 12/8/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class FaceBookLoginViewController: UIViewController, FBSDKLoginButtonDelegate
{

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //First check if access token already there
        //If exist we will log it
      /*      let loginButton = FBSDKLoginButton();
       
        loginButton.center = self.view.center
        loginButton.delegate = self;
        self.view.addSubview(loginButton)
        */
        
         loginButton.delegate = self;
         loginButton.readPermissions = ["public_profile", "email"]
        
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            print("we have the token")
            
          let rootView = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            appDel.window?.rootViewController = rootView 
        }

    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FBSDKLoginButtonDelegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if(error == nil)
        {
            print("Success login")
            
    
            let token : FBSDKAccessToken = result.token

          
            print("Token: \(FBSDKAccessToken.currentAccessToken().tokenString)")
            
            print("user ID \(FBSDKAccessToken.currentAccessToken().userID)")
            
            let rootView = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            appDel.window?.rootViewController = rootView

        }
        else
        {
           print(error.localizedDescription)
            print("Problem logging in")
            return;
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
        FBSDKAccessToken.setCurrentAccessToken(nil)
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
