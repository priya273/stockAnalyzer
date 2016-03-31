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




class FaceBookLoginViewController: UIViewController, FBSDKLoginButtonDelegate, UserExistDelegate
{
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    var activityIndicatorView : UIActivityIndicatorView?
    var userManager : UserManager?
    
    //https://developers.facebook.com/docs/ios/getting-started
    //Images: 
    //App settings
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        
        userManager = UserManager()
        userManager?.delegate = self;
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView!.center = self.view.center
        activityIndicatorView!.color = UIColor.whiteColor()
        activityIndicatorView!.hidden = true
        self.view.addSubview(activityIndicatorView!)
        
        loginButton.delegate = self;
        loginButton.readPermissions = ["public_profile", "email"]
        
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            print("we have the token")
    
            //Get user
            if(self.userManager!.GetUserEntity(FBSDKAccessToken.currentAccessToken().userID))
            {
                    NavigateToRootViewController()
            }
            
        }

    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FBSDKLoginButtonDelegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
       
        if(error == nil && (!result.isCancelled))
        {
            print("Success login")
        
            loginButton.hidden = true
            activityIndicatorView!.hidden = false;
            activityIndicatorView!.startAnimating()
        
            self.GetUserData()
    
        }
        else if(result.isCancelled)
        {
            print("Canceled clicked")
            ShowFaceBookLogin()
        }
        else
        {
            print(error.localizedDescription)
            print("Problem logging in")
            return;
        }
        
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out")
        FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
    func ShowFaceBookLogin()
    {
       loginButton.hidden = false
        FBSDKAccessToken.setCurrentAccessToken(nil)
        let facebookloginpage = self.storyboard?.instantiateViewControllerWithIdentifier("FaceBookLoginViewController") as! FaceBookLoginViewController
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.window?.rootViewController = facebookloginpage
    }

    
    func GetUserData()
    {
       
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, first_name, email"])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if(error != nil)
            {
                
            }
           
            else
            {
                let user : UserEntity = UserEntity()
                user.name = result.valueForKey("first_name") as? String
                user.email = result.valueForKey("email") as? String
                user.id = result.valueForKey("id") as? String
            
                self.userManager!.ValidateUser(user)

            }
        
        })
        

    }
    func UserExistsOrCreated()
    {
        self.activityIndicatorView?.hidden = true
        self.activityIndicatorView?.stopAnimating()
        NavigateToRootViewController()
    }
    func UnableToRetriveOrCreateUser()
    {
        self.activityIndicatorView?.hidden = true
        self.activityIndicatorView?.stopAnimating()
        self.ShowFaceBookLogin()
    }
    
    func NavigateToRootViewController()
    {
        
        let rootView = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.window?.rootViewController = rootView

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
