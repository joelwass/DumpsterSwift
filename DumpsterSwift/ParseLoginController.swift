//
//  ParseLoginController.swift
//  Dumpster
//
//  Created by Joel Wasserman on 12/25/15.
//  Copyright © 2015 IVET. All rights reserved.
//


import UIKit

class ParseLoginController: UIViewController, PFLogInViewControllerDelegate,
PFSignUpViewControllerDelegate {
    
    var window: UIWindow?
    var user:PFUser?
    var questionArrayFirst:NSMutableArray = NSMutableArray()
    var answerArrayFirst:NSMutableArray = NSMutableArray()
    
    let signupViewController = PFSignUpViewController()
    let loginViewController = PFLogInViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        user = PFUser.currentUser()
        if user != nil {
            //move to new view controller
            print("user logged in")
            UserService.sharedInstance.queryUserScore(self)
            
        }
        else {

            print("No Logged in user")
            
            let logInLogoTitle = UILabel()
            logInLogoTitle.text = "DUMPSTERSWIFT"
            logInLogoTitle.font = UIFont(name: "Chalkduster", size:28)
            
            loginViewController.emailAsUsername = true
            loginViewController.logInView!.logo = logInLogoTitle
            loginViewController.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.PasswordForgotten, PFLogInFields.SignUpButton, PFLogInFields.Facebook]
            loginViewController.delegate = self

            let signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "DUMPSTERSWIFT"
            signUpLogoTitle.font = UIFont(name: "Chalkduster", size:28)
            
            signupViewController.emailAsUsername = true
            signupViewController.delegate = self
            signupViewController.signUpView!.logo = signUpLogoTitle
            
            loginViewController.signUpController = signupViewController
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    
    func loadQuestionView() {
        
        print("attempting to laod question view")
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //let currentInstallation = PFInstallation.currentInstallation()
        
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("qVC") as! QuestionViewController
        let navController = UINavigationController(rootViewController: viewController)
        viewController.questionArray = self.questionArrayFirst
        viewController.answerArray = self.answerArrayFirst
        
        self.window!.rootViewController = navController
        self.window!.makeKeyAndVisible()
    }
    
    //MARK: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        
        if(!username.isEmpty || !password.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        UserSettings.sharedInstance.Username = user.username!
        print("just completed loggin in for user: \(UserSettings.sharedInstance.Username)")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        setInstallations(user)
    }
    
    func setInstallations(user: PFUser) {
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setObject(user.username!, forKey: "Username")
        currentInstallation.saveEventually()
        
        //TEST
        //        user.setObject(currentInstallation, forKey: "installation")
        //        user.saveEventually()
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("failed to login")
    }
    
    //Mark: Parse Signup
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        return true
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        user.setObject(0, forKey: "score")
        user.saveEventually()
        UserSettings.sharedInstance.Username = user.username!
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("failed to sign up")
        print("\(error)")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("user dismissed signup")
    }
    
    //Mark: Actions
    
    @IBAction func logoutUser(sender: UIButton) {
        PFUser.logOut()
    }
    
}

