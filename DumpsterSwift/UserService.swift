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
    var skips:Int?
    var incorrectGuesses:Int?
    var questionCount:Int?
    
    public class var sharedInstance: UserService {
        return _UserService
    }
    
    func queryUserScore(sender: AnyObject) {
        
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: UserSettings.sharedInstance.Username!)
        query.findObjectsInBackgroundWithBlock{(user: [PFObject]?, error:NSError?) -> Void in
            if error == nil {
                print ("query for user score successful")
                if let objects = user {
                    
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
            if let userSkips:AnyObject = each["skipCount"] {
                self.skips = (userSkips as! NSNumber) as Int
                UserSettings.sharedInstance.userSkips = self.skips
            }
            if let userQuestionCount:AnyObject = each["questionCount"] {
                self.questionCount = (userQuestionCount as! NSNumber) as Int
                UserSettings.sharedInstance.userQuestions = self.questionCount
            }
            if let userIncorrectGuesses:AnyObject = each["incorrectGuessesCount"] {
                self.incorrectGuesses = (userIncorrectGuesses as! NSNumber) as Int
                UserSettings.sharedInstance.userIncorrectGuesses = self.incorrectGuesses
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
        currentUser!.setObject(score, forKey: "score")
        currentUser!.saveEventually()
    }
    
    func updateSkips(skips: Int) {
        UserSettings.sharedInstance.userSkips = skips
        
        let currentUser = PFUser.currentUser()
        currentUser!.setObject(skips, forKey: "skipCount")
        currentUser!.saveEventually()
    }
    
    func updateQuestionCount(questionCount: Int) {
        UserSettings.sharedInstance.userQuestions = questionCount

        let currentUser = PFUser.currentUser()
        currentUser!.setObject(questionCount, forKey: "questionCount")
        currentUser!.saveEventually()
    }
    
    func updateIncorrectGuesses(incorrectGuesses: Int) {
        UserSettings.sharedInstance.userIncorrectGuesses = incorrectGuesses
        
        let currentUser = PFUser.currentUser()
        currentUser!.setObject(incorrectGuesses, forKey: "incorrectGuessesCount")
        currentUser!.saveEventually()
    }
}