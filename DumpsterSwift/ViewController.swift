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
    var questionArray: NSMutableArray!
    

  

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
    }
    
    func makeQuestions(skipNum: Int) {
        var PFQuery = PFQuery(classname:"Questions")
        PFQuery.setLimit(5)
        PFQuery.setSkip(skipNum)
        PFQuery.getObjectInBackgroundWithBlock(objects: PFObject!, error: NSError!) {
            if !error {
                println("make Questions succesfully pressed and grabbing")
                questionArray = objects.mutableCopy
                
            } else {
                println("we got an error within our make questions PFQuery")
            }
        }
    }
    

}

