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
      
   view.setTranslatesAutoresizingMaskIntoConstraints(false)
    super.viewDidLoad()
    startButton.hidden = true
    buildQuestions()
        
    homeLabel.font = UIFont(name: "Chalkduster", size:18)
    startButton.titleLabel!.font = UIFont(name: "Chalkduster", size: 18)
        
    //gif animation code
    let gifString = NSBundle.mainBundle().URLForResource("DumpLoopTrans2", withExtension: "gif")
    let gif = NSData(contentsOfURL: gifString!)
    gifView.loadData(gif, MIMEType:"image/gif", textEncodingName: nil, baseURL: nil)
    gifView.userInteractionEnabled = false;
    self.view .addSubview(gifView)
  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func buttonPressed(sender : AnyObject) {
        println("start button pressed")
    }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuestionSegue" {
            
            var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("qVC") as! QuestionViewController
            let navController = UINavigationController(rootViewController: viewController)
            viewController.questionArray = self.questionArrayFirst
            viewController.answerArray = self.answerArrayFirst

            presentViewController(navController, animated: true, completion: nil)
        }
    }
  
  func buildQuestions() {
        let skipNum = Int(arc4random_uniform(200))

        var findQuestions = PFQuery(className: "Questions")
        findQuestions.limit = 5
        findQuestions.skip = skipNum
        findQuestions.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if (error == nil) {
                println("Succesfully retreived \(objects.count) objects")
                if let objects = objects as? [PFObject!] {
                    self.questionArrayFirst.addObjectsFromArray(objects)
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
                    self.makeButtonVisible()
                }
            }
            else {
                NSLog("error")
            }
        }
        NSLog("Succesfully built Questions")
    }
  
  func makeButtonVisible() {
        startButton.hidden = false
    }
}