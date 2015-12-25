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
    
}
