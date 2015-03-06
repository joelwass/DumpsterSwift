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
    var questionArray:NSMutableArray = NSMutableArray()
    var answerArray:NSMutableArray = NSMutableArray()
    var correctAnswer:NSString!
    var answerLabelArray:NSMutableArray = NSMutableArray()
    var buttonArray:NSMutableArray = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildQuestions({ (result) -> Void in
            if (result == true) {
                println("Working")
                self.populateQuestions()
            } else {
                println("not working")
            }
        })
       
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateQuestions() {
        
        var randomKey = Int(arc4random_uniform(UInt32(questionArray.count)))
    
        println(randomKey)
        var buttonArray = [answer1, answer2, answer3, answer4]
        
        
        println("Stuff2")
        var answerLabelArray = [answerArray[randomKey].valueForKey("Answer"), answerArray[randomKey].valueForKey("IncAnswer2"), answerArray[randomKey].valueForKey("IncAnswer3"), answerArray[randomKey].valueForKey("IncAnswer1")]
        
        println("Stuff3")
        questionLabel.text = questionArray[randomKey].valueForKey("Question") as NSString
        self.correctAnswer = answerArray[randomKey].valueForKey("Answer") as NSString
        
        println("stuff4")
        for (var i = 0; i < 4; i++) {
            var randomLabel = Int(arc4random() % UInt32(answerLabelArray.count))
            println(answerLabelArray.count)
            println(randomLabel)
            
            
            
            
            
            /* problem right now being that it's running into nil because the answer label at given randomLabel value is being removed.
            so if a randomLabel repeats itself then it runs into nil and crashes
            */
            
            
            
            
            
            
            buttonArray[i].setTitle(answerLabelArray[randomLabel] as NSString, forState:UIControlState())
            
            answerLabelArray.removeAtIndex(randomLabel)
            
            
            
        }
        
        answerArray.removeObjectAtIndex(randomKey)
        questionArray.removeObjectAtIndex(randomKey)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    func buildQuestions(completion: (result: Bool) -> Void) {
        
        let skipNum = Int(arc4random_uniform(200))
        //remove all questions from the array each time.
        self.questionArray.removeAllObjects()
        self.answerArray.removeAllObjects()
        
        
        var findQuestions = PFQuery(className: "Questions")
        findQuestions.limit = 5
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil) {
                
                
                
                if let objects = objects as? [PFObject!] {
                    
                    self.questionArray.addObjectsFromArray(objects)
                    println("Succesfully retreived \(objects.count) Questions")
                                        for element in self.questionArray {
                                            println(element)
                                        }
                    
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
                    
                    
                    println("Succesfully retreived \(objects.count) answerSets")
                                        for element in self.answerArray {
                                            println(element)
                                        }
                    
                    if (self.answerArray[2].valueForKey("Answer") != nil) {
                        println("not answers")
                    }
                    if (self.questionArray[1].valueForKey("Question") != nil) {
                        println("not question")
                        completion(result: true)
                    }
                    
                }
            }
            else {
                NSLog("error")
            }
        }
        
        NSLog("Succesfully built Questions")


        //        for element in self.questionArray {
        //            println(element)
        //        }
    }


}
