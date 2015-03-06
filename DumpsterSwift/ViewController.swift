//
//  ViewController.swift
//  DumpsterSwift
//
//  Created by Joel Wasserman on 2/17/15.
//  Copyright (c) 2015 IVET. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var gifView: UIWebView!
    @IBOutlet weak var startButton: UIButton!
    var questionArrayFirst:NSMutableArray = NSMutableArray()
    var answerArrayFirst:NSMutableArray = NSMutableArray()
    

  

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buildQuestions()
        
        homeLabel.font = UIFont(name: "Chalkduster", size:18)
        startButton.titleLabel!.font = UIFont(name: "Chalkduster", size: 18)
        
        //gif animation code
        let gifString = NSBundle.mainBundle().URLForResource("DumpLoopTrans2", withExtension: "gif")
        let gif = NSData(contentsOfURL: gifString!)
        gifView .loadData(gif, MIMEType:"image/gif", textEncodingName: nil, baseURL: nil)
        gifView.userInteractionEnabled = false;
        [self.view .addSubview(gifView)]
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender : AnyObject) {
        println("start button pressed")
        
        //call make questions to populate questionArray


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuestionSegue" {
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("qVC") as QuestionViewController
            viewController.questionArray = self.questionArrayFirst
            viewController.answerArray = self.answerArrayFirst
            
            self.presentViewController(viewController, animated: true, completion: nil)
//            if let questionVC = segue.destinationViewController as? QuestionViewController {
//                questionVC.questionArray = self.questionArrayFirst
//                questionVC.answerArray = self.answerArrayFirst
//            }
        }
    }
    

    func buildQuestions() {
        
        let skipNum = Int(arc4random_uniform(200))
        //remove all questions from the array each time.
        //questionArray.removeAllObjects()
        

        var findQuestions = PFQuery(className: "Questions")
        findQuestions.limit = 5
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil) {
                
                println("Succesfully retreived \(objects.count) objects")
                    
                if let objects = objects as? [PFObject!] {
                    
                    self.questionArrayFirst.addObjectsFromArray(objects)
                    println(self.questionArrayFirst[3].valueForKey("Question"))
//                    for element in self.questionArray {
//                        println(element)
//                    }

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
                
                 println("Succesfully retreived \(objects.count) objects")

                
                if let objects = objects as? [PFObject!] {
                    self.answerArrayFirst.addObjectsFromArray(objects)
                    
                    println("answers done")
//                    for element in self.answerArray {
//                        println(element)
//                    }
                    
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