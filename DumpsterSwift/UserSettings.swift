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
        static let RelayForLife = "RelayForLife"
        static let ACappella = "ACappella"
        static let DancePerformances = "DancePerformances"
        static let BlackStudentMovement = "BlackStudentMovement"
        static let CUAB = "CUAB"
        static let FreeFood = "FreeFood"
        static let StudentGovernment = "StudentGovernment"
        static let ClubSports = "ClubSports"
        static let BarEvents = "BarEvents"
        static let CAA = "CAA"
        static let Username = "Username"
        static let SyllabusArray = "SyllabusArray"
        static let EventsArray = "EventsArray"
        static let notificationsScheduled = "notificationsScheduled"
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
    
}
