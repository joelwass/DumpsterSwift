//
//  StatsViewController.swift
//  DumpsterSwift
//
//  Created by Joel Wasserman on 3/8/15.
//  Copyright (c) 2015 IVET. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    var score:Int = 0
    var skipCount:Int = 0
    var questionCount:Int = 0
    var attemptCount:Int = 0
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    override func viewDidLoad() {
        
        var nav = self.navigationController?.navigationBar

        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.orangeColor()
        
        
        super.viewDidLoad()
       
        labelOne.text = NSString(format: "Score: %d", score)
        labelTwo.text = NSString(format: "Skip Count: %d", skipCount)
        labelThree.text = NSString(format: "Question Count: %d", questionCount)
        labelFour.text = NSString(format: "Attempts: %d", attemptCount)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
