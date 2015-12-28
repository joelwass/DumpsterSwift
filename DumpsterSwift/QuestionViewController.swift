//
//  QuestionViewController.swift
//  DumpsterSwift
//
//  Created by Joel Wasserman on 2/17/15.
//  Copyright (c) 2015 IVET. All rights reserved.
//

import UIKit
import Foundation

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    var questionArray:NSMutableArray = NSMutableArray()
    var answerArray:NSMutableArray = NSMutableArray()
    var correctAnswer:NSString!
    var answerLabelArray:NSMutableArray = NSMutableArray()
    var buttonArray:NSMutableArray = NSMutableArray()
    var score:Int = 0
    var skipCount:Int = 0
    var questionCount:Int = 0
    var attemptCount:Int = 0
    var correctAnswerCount:Int = 0
    var incorrectAnswerCount:Int = 0
    var tmpArray:Array<Int> = [12,13,14,15]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.score = UserSettings.sharedInstance.userScore!
        self.skipCount = UserSettings.sharedInstance.userSkips!
        self.questionCount = UserSettings.sharedInstance.userQuestions!
        self.incorrectAnswerCount = UserSettings.sharedInstance.userIncorrectGuesses!
      
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.orangeColor()
        self.answer1.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.answer2.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.answer3.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.answer4.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.answer1.titleLabel?.text = ""
        self.answer2.titleLabel?.text = ""
        self.answer3.titleLabel?.text = ""
        self.answer4.titleLabel?.text = ""
        
        scoreLabel.text = NSString(format: "Score: %d", score) as String
        self.populateQuestions()
    }
    
    @IBAction func statsPressed(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("statsVC") as! StatsViewController
        viewController.score = score
        viewController.skipCount = skipCount
        viewController.questionCount = questionCount
        viewController.correctAnswerCount = correctAnswerCount
        viewController.incorrectAnswerCount = incorrectAnswerCount
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipPressed() {
        skipCount += 1
        self.populateQuestions()
        UserService.sharedInstance.updateSkips(skipCount)
    }
    
    func populateQuestions() {
        let randomKey = Int(arc4random_uniform(UInt32(questionArray.count)))
        var buttonArray = [answer1, answer2, answer3, answer4]
        var answerLabelArray = [answerArray[randomKey].valueForKey("Answer")
            , answerArray[randomKey].valueForKey("IncAnswer2")
            , answerArray[randomKey].valueForKey("IncAnswer3")
            , answerArray[randomKey].valueForKey("incAnswer1")]
        var arrayOfButtonNumbers = [5,6,7,8]
        var i = 0
        
        questionLabel.text = questionArray[randomKey].valueForKey("Question") as! NSString as String
        self.correctAnswer = answerArray[randomKey].valueForKey("Answer") as! NSString
        while (i < 4) {
            let buttonNumber = Int(arc4random() % UInt32(4))
            if (buttonNumber == arrayOfButtonNumbers[0] || buttonNumber == arrayOfButtonNumbers[1]
                || buttonNumber == arrayOfButtonNumbers[2]
                || buttonNumber == arrayOfButtonNumbers[3]) {
                continue
            } else {
                arrayOfButtonNumbers[i] = buttonNumber
                if let answerTemp = answerLabelArray[buttonNumber] as? NSString {
                    buttonArray[i].setTitle(answerTemp as String, forState:UIControlState())
                    i++
                }
            }
        }
        answerArray.removeObjectAtIndex(randomKey)
        questionArray.removeObjectAtIndex(randomKey)
        
        if (questionArray.count == 0) {
            self.buildQuestions()
        }
    }
    
    func buildQuestions() {
        let skipNum = Int(arc4random_uniform(200))
        let findQuestions = PFQuery(className: "Questions")
        findQuestions.limit = 1
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error:NSError?)->Void in
            if (error == nil) {
                if let objects = objects {
                    self.questionArray.addObjectsFromArray(objects)
                }
            }
            else {
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
        
        let findAnswers = PFQuery(className: "Answers")
        findAnswers.limit = 1
        findAnswers.skip = skipNum
        findAnswers.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error:NSError?)->Void in
            if (error == nil && objects != nil) {
                if let objects = objects  {
                    self.answerArray.addObjectsFromArray(objects)
                }
            }
            else {
                NSLog("error")
            }
        }
        NSLog("Succesfully built Questions")
    }
    
    func updateScore() {
        scoreLabel.text = NSString(format: "Score: %d", score) as String
        UserService.sharedInstance.updateScore(score)
    }
    
    @IBAction func guessPressed(sender: UIButton) {
        questionCount += 1
        
        UserService.sharedInstance.updateQuestionCount(questionCount)
        if (sender.currentTitle == self.correctAnswer) {
            correctAnswerCount += 1
            score += 2
            updateScore()
            
            let alert = UIAlertController(title: "Nice!",
              message: "Click Learn More to learn about the answer!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Learn More",
              style: UIAlertActionStyle.Default, handler: { action in
                switch action.style{
                case .Default:
                    print("learn more")
                    self.learnMore()
                case .Cancel:
                    print("cancel")
                case .Destructive:
                    print("destructive")
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Next",
              style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("next")
                    self.populateQuestions()
                case .Cancel:
                    print("cancel")
                case .Destructive:
                    print("destructive")
                }
            }))
        } else {
            UIView.animateWithDuration(0.3, delay: 0.0, options: [], animations: {
                sender.backgroundColor = UIColor.redColor()
                }, completion: { finished in
                    UIView .animateWithDuration(0.2, animations: {
                    sender.backgroundColor = UIColor.whiteColor()
                })
            })
            incorrectAnswerCount += 1
            score -= 1
            self.updateScore()
            UserService.sharedInstance.updateIncorrectGuesses(incorrectAnswerCount)
        }
    }
    
    func learnMore() {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("learnMore") as! LearnMoreViewController
        viewController.correctAnswer = correctAnswer
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
