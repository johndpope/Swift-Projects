//
//  CalcGPAViewController.swift
//  NYU GPA
//
//  Created by Mohan Dhar on 6/3/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class CalcGPAViewController: UIViewController {
    @IBOutlet var calculatedGPALabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var studentTotal = 0.0;
        var creditsTaken = 0.0;
        for (var i = 0; i < courses.count; ++i) {
            studentTotal += courses[i].grade * courses[i].numCredts
            creditsTaken += courses[i].numCredts
        }
        print(studentTotal)
        print(creditsTaken)
        let totalGrade = studentTotal / creditsTaken
        
        // Formatting a decimal
        calculatedGPALabel.text = NSString(format: "%.3f", totalGrade) as String
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
