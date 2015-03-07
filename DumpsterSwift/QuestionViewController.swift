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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        self.updateScore()
        self.populateQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipPressed() {
        self.buildQuestions()
        self.populateQuestions()
    }
    
    func populateQuestions() {
        
        var randomKey = Int(arc4random_uniform(UInt32(questionArray.count)))
    
        println(randomKey)
        var buttonArray = [answer1, answer2, answer3, answer4]
        
        var answerLabelArray = [answerArray[randomKey].valueForKey("Answer"), answerArray[randomKey].valueForKey("IncAnswer2"), answerArray[randomKey].valueForKey("IncAnswer3"), answerArray[randomKey].valueForKey("incAnswer1"), nil]
        
        questionLabel.text = questionArray[randomKey].valueForKey("Question") as NSString
        self.correctAnswer = answerArray[randomKey].valueForKey("Answer") as NSString
  
        var answerCount = 3
        var k = 0
        var tmp = [21, 22, 23, 24]
        while (k < (answerCount+1)) {
            var randomNumber = Int(arc4random() % UInt32(answerCount+1))
            if (randomNumber == tmp[0] || randomNumber == tmp[1] || randomNumber == tmp[2] || randomNumber == tmp[3]) {
                continue
            } else {
                tmp[k] = randomNumber
                println("randomNumber \(randomNumber) \(answerLabelArray[randomNumber])")
                println(tmp)
                if let answerTemp = answerLabelArray[randomNumber] as? NSString {
                    buttonArray[k].setTitle(answerTemp, forState:UIControlState())
                    //answerLabelArray.removeAtIndex(randomNumber)
                    k++
                }
                else {
                    println("hit nil")
                    continue
                }
            }
        }
        
        k=0
        answerCount = 4
        
        answerArray.removeObjectAtIndex(randomKey)
        questionArray.removeObjectAtIndex(randomKey)
    }
    
    func buildQuestions() {
        
        let skipNum = Int(arc4random_uniform(200))
        
        
        var findQuestions = PFQuery(className: "Questions")
        findQuestions.limit = 5
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil) {
                
                if let objects = objects as? [PFObject!] {
                    
                    self.questionArray.addObjectsFromArray(objects)
                    
                }
            }
            else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
        var findAnswers = PFQuery(className: "Answers")
        findAnswers.limit = 5
        findAnswers.skip = skipNum
        findAnswers.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil && objects != nil) {
                
     
                if let objects = objects as? [PFObject!] {
                    self.answerArray.addObjectsFromArray(objects)
                    
                    
                    for element in self.answerArray {
                        println(element)
                    }

                }
            }
            else {
                NSLog("error")
            }
        }
        
        NSLog("Succesfully built Questions")
    }
    
    func updateScore() {
        scoreLabel.text = NSString(format: "%d", score)
    }
    
    @IBAction func guessPressed(sender: UIButton) {
        if (sender.currentTitle == self.correctAnswer) {
            score += 2
            self.updateScore()
            
        } else {
            UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: {
                sender.backgroundColor = UIColor.redColor()
                }, completion: { finished in
                    UIView .animateWithDuration(0.2, animations: {
                    sender.backgroundColor = UIColor.whiteColor()
                })
            })
            score -= 1
            self.updateScore()
            
        }
    }

}
