//
//  UserService.swift
//  Dumpster
//
//  Created by Joel Wasserman on 12/25/15.
//  Copyright © 2015 IVET. All rights reserved.
//

import Foundation

private let _UserService = UserService()

public class UserService:NSObject {
    
    var userDetailsFromParse:NSMutableArray?
    var score:Int?
    
    public class var sharedInstance: UserService {
        return _UserService
    }
    
    func queryUserScore(sender: AnyObject) {
        
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: UserSettings.sharedInstance.Username!)
        query.findObjectsInBackgroundWithBlock{(user: [AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                print ("query for user score successful")
                if let objects = user as? [AnyObject!] {
                    
                    self.userDetailsFromParse = NSMutableArray()
                    self.userDetailsFromParse!.addObjectsFromArray(objects)
                    self.getUserScore(sender)
                }
                else {
                    self.finish(sender)
                }
            }
            else {
                print("error in parse login controller \(error)")
            }
        }

    }
    
    func getUserScore(sender: AnyObject) {
        for each in userDetailsFromParse! {
            if let userScore:AnyObject = each["score"] {
                self.score = (userScore as! NSNumber) as Int
                UserSettings.sharedInstance.userScore = self.score
            }
        }
        self.finish(sender)
    }
    
    func finish(sender: AnyObject) {
        if sender is ParseLoginController {
            let mysender = sender as! ParseLoginController
            mysender.loadQuestionView()
        }
    }
    
    func updateScore(score: Int) {
        UserSettings.sharedInstance.userScore = score
        
        let currentUser = PFUser.currentUser()
        currentUser.setObject(score, forKey: "score")
        currentUser.saveEventually()
    }
}