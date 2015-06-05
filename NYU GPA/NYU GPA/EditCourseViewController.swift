//
//  EditCourseViewController.swift
//  NYU GPA
//
//  Created by Mohan Dhar on 6/3/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit


class EditCourseViewController: UIViewController {
    @IBOutlet var courseTitleLabel: UILabel!
    @IBOutlet var letterGradeLabel: UILabel!
    @IBOutlet var numCreditsLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!

    var course:Course = Course();
    var index = 0;

    
    let numToLetter:[Double : String] = [4.0 : "A", 3.7 : "A-", 3.3 : "B+", 3.0 : "B", 2.7 : "B-", 2.3 : "C+", 2.0 : "C", 1.7 : "C-", 1.3 : "D+", 1.0 : "D", 0.0 : "F" ]

    let year:[Int : String] = [0 : "Freshman", 1 : "Sophomore", 2 : "Junior", 3 : "Senior"]
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController.isKindOfClass(EditViewController)) {
            var destination:EditViewController = segue.destinationViewController as EditViewController
            destination.editCourse = course;
            destination.index = index
        }
    }
    
    func setLabels() -> Void {
        self.navigationItem.title = "Details"
        courseTitleLabel.text = course.name
        letterGradeLabel.text = "\(numToLetter[course.grade]!)"
        numCreditsLabel.text = "\(course.numCredts)"
        yearLabel.text = "\(year[course.year]!)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLabels()
        
        for (var i = 0; i < courses.count; ++i) {
            if (course.name == courses[i].name) {
                index = i;
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        setLabels()
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
