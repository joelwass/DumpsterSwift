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
    var correctAnswerCount:Int = 0
    var incorrectAnswerCount:Int = 0
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()
      
      var nav = self.navigationController?.navigationBar
      
      nav?.barStyle = UIBarStyle.Black
      nav?.tintColor = UIColor.orangeColor()
      

        labelOne.text = NSString(format: "Score: %d", score)
        labelTwo.text = NSString(format: "Skip Count: %d", skipCount)
        labelThree.text = NSString(format: "Question Count: %d", questionCount)
        labelFour.text = NSString(format: "Incorrect Guesses: %d", incorrectAnswerCount)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
