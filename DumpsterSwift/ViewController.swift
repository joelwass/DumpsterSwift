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
    var questionArray:NSMutableArray = NSMutableArray()
    var answerArray:NSMutableArray = NSMutableArray()
    

  

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
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
        buildQuestions()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuestionSegue" {
            if let questionVC = segue.destinationViewController as? QuestionViewController {
                questionVC.questionArray = questionArray
                questionVC.answerArray = answerArray
            }
        }
    }
    

    func buildQuestions() {
        
        let skipNum = Int(arc4random_uniform(200))
        //remove all questions from the array each time.
        //questionArray.removeAllObjects()
        

        var findQuestions:PFQuery = PFQuery(className: "Questions")
        findQuestions.limit = 5
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil) {
                if let questions = objects as? [PFObject!] {
                    for object:PFObject! in questions {
                        self.questionArray.addObject(object)
                    }
                }
            }
            else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
        var findAnswers:PFQuery = PFQuery(className: "Answers")
        findAnswers.limit = 5
        findAnswers.skip = skipNum
        findAnswers.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil) {
                if let answers = objects as? [PFObject!] {
                    for object:PFObject! in answers {
                        self.answerArray.addObject(object)
                    }
                }
            }
        }
        NSLog("Succesfully built Questions")
    }
}