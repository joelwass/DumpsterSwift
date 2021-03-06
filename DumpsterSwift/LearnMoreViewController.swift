//
//  LearnMoreViewController.swift
//  DumpsterSwift
//
//  Created by Joel Wasserman on 3/14/15.
//  Copyright (c) 2015 IVET. All rights reserved.
//

import UIKit


class LearnMoreViewController: UIViewController {
    var correctAnswer:NSString = ""
    var answerURLString:NSString = ""
    var answerURL:NSURL!
    var urlRequest:NSURLRequest!
    var incompleteURL:NSString = "https://en.wikipedia.org/wiki/"
    
    @IBOutlet weak var learnMoreWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeSpaces()
        self.convertToRequest(answerURLString)
        learnMoreWebView.loadRequest(urlRequest)
    }
    
    func removeSpaces() {
        answerURLString = correctAnswer.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    func convertToRequest(string: NSString) {
        answerURLString = incompleteURL.stringByAppendingString(answerURLString as String)
        answerURL = NSURL(string: answerURLString as String)
        urlRequest = NSURLRequest(URL: answerURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
