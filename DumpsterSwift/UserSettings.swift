//
//  UserSettings.swift
//  Dumpster
//
//  Created by Joel Wasserman on 12/25/15.
//  Copyright © 2015 IVET. All rights reserved.
//

import Foundation

private let _UserSettings = UserSettings()

public class UserSettings {
    
    struct Constants {
        static let Score = "Score"
        static let Skips = "Skips"
        static let Questions = "Questions"
        static let IncorrectGuesses = "IncorrectGuesses"
        static let Username = "Username"
    }
    
    public class var sharedInstance: UserSettings {
        return _UserSettings
    }
    
    public var Username:String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey(Constants.Username)
        }
        set (newUsername) {
            NSUserDefaults.standardUserDefaults().setObject(newUsername, forKey: Constants.Username)
        }
    }
    
    public var userScore:Int? {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(Constants.Score)
        }
        set (newScore) {
            NSUserDefaults.standardUserDefaults().setInteger(newScore!, forKey: Constants.Score)
        }
    }
    
    public var userSkips:Int? {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(Constants.Skips)
        }
        set (newSkips) {
            NSUserDefaults.standardUserDefaults().setInteger(newSkips!, forKey: Constants.Skips)
        }
    }
    
    public var userQuestions:Int? {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(Constants.Questions)
        }
        set (newQuestions) {
            NSUserDefaults.standardUserDefaults().setInteger(newQuestions!, forKey: Constants.Questions)
        }
    }
    
    public var userIncorrectGuesses:Int? {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(Constants.IncorrectGuesses)
        }
        set (newIncorrectGuesses) {
            NSUserDefaults.standardUserDefaults().setInteger(newIncorrectGuesses!, forKey: Constants.IncorrectGuesses)
        }
    }
    
}
