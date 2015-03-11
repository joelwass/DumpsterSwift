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
    var incorrectAnswerCount:Int = 0
    var correctAnswerCount:Int = 0
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    
    override func viewDidLoad() {
        
        var nav = self.navigationController?.navigationBar

        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        
        
        super.viewDidLoad()
       
        labelOne.text = NSString(format: "Score: %d", score)
        labelTwo.text = NSString(format: "Skip Count: %d", skipCount)
        labelThree.text = NSString(format: "Question Count: %d", questionCount)
        labelFour.text = NSString(format: "Incorrect Tries: %d", incorrectAnswerCount)
        labelFive.text = NSString(format: "Correct Tries: %d", correctAnswerCount)

    }
    
    @IBAction func goBack() {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
