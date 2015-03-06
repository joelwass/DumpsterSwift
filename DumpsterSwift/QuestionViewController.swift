//
//  QuestionViewController.swift
//  DumpsterSwift
//
//  Created by Joel Wasserman on 2/17/15.
//  Copyright (c) 2015 IVET. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    var questionArray:NSMutableArray!
    var answerArray:NSMutableArray!
    var correctAnswer:NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.populateQuestions()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateQuestions() {
        var randomKey = Int(arc4random_uniform(5))
        
        var buttonArray = [answer1, answer2, answer3, answer4]
        var answerLabelArray = [answerArray[randomKey].valueForKey("Answer"), answerArray[randomKey].valueForKey("IncAnswer2"), answerArray[randomKey].valueForKey("IncAnswer3"), answerArray[randomKey].valueForKey("IncAnswer1")]
        
        questionLabel.text = questionArray[randomKey].valueForKey("Question") as NSString
        self.correctAnswer = answerArray[randomKey].valueForKey("Answer") as NSString
        
        for (var i = 0; i < 4; i++) {
            var randomLabel = Int(arc4random_uniform(4))
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

}
