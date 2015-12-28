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
      
        view.translatesAutoresizingMaskIntoConstraints = false
        super.viewDidLoad()
        startButton.hidden = true
        buildQuestions()
            
        homeLabel.font = UIFont(name: "Chalkduster", size:18)
        startButton.titleLabel!.font = UIFont(name: "Chalkduster", size: 18)
            
        //gif animation code
        let gifString = NSBundle.mainBundle().URLForResource("DumpLoopTrans2", withExtension: "gif")
        let gif = NSData(contentsOfURL: gifString!)

        gifView.loadData(gif!, MIMEType:"image/gif", textEncodingName: "", baseURL: NSURL())
        gifView.userInteractionEnabled = false;
        self.view .addSubview(gifView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender : AnyObject) {
        print("start button pressed")
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("parseViewController") as! ParseLoginController
        VC.questionArrayFirst = self.questionArrayFirst
        VC.answerArrayFirst = self.answerArrayFirst
        self.presentViewController(VC, animated: true, completion: nil)
    }
  
    func buildQuestions() {
        let skipNum = Int(arc4random_uniform(200))

        let findQuestions = PFQuery(className: "Questions")
        findQuestions.limit = 5
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock({
            (objects:[PFObject]?, error:NSError?) -> Void in
            if (error == nil) {
                print("Succesfully retreived \(objects!.count) objects")
                if let objects = objects  {
                    self.questionArrayFirst.addObjectsFromArray(objects)
                }
            }
            else {
                // Log details of the failure
                NSLog("Error querying for question first time view controller: %@ %@", error!, error!.userInfo)
            }
        })
    
        let findAnswers = PFQuery(className: "Answers")
        findAnswers.limit = 5
        findAnswers.skip = skipNum
        findAnswers.findObjectsInBackgroundWithBlock({
            (objects:[PFObject]?, error:NSError?)->Void in
            if (error == nil && objects != nil) {
                 print("Succesfully retreived \(objects!.count) objects")
                if let objects = objects {
                    self.answerArrayFirst.addObjectsFromArray(objects)
                    self.makeButtonVisible()
                }
            }
            else {
                NSLog("error in querying for answers first time view controller")
            }
        })
        NSLog("Succesfully built Questions")
    }
  
    func makeButtonVisible() {
        startButton.hidden = false
    }
}