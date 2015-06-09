//
//  NYUViewController.swift
//  NYU GPA
//
//  Created by Mohan Dhar on 6/3/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

let COURSE_NAME = "course_name"
let COURSE_GRADE = "course_grade"
let NUM_CREDITS = "num_credits"
let COURSE_YEAR = "course_year"
let COURSES = "all_courses"

class NYUViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet var courseNameOutlet: UITextField!
    @IBOutlet var year: UISegmentedControl!
    @IBOutlet var numCreditsLabel: UILabel!
    @IBOutlet var stepperOutlet: UIStepper!
    @IBOutlet var letterGradePicker: UIPickerView!
    
    let grades:[String : Double] = ["A" : 4.0, "A-" : 3.7, "B+" : 3.3, "B" : 3.0, "B-" : 2.7, "C+" : 2.3, "C" : 2.0, "C-" : 1.7, "D+" : 1.3, "D" : 1.0, "F" : 0.0]
    let pickerData = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "F"]
    
    @IBAction func stepperPressed(sender: UIStepper) {
        numCreditsLabel.text = "\(stepperOutlet.value)"
    }

    @IBAction func savePressed(sender: UIBarButtonItem) {
        let name = courseNameOutlet.text
        let grade = grades[pickerData[letterGradePicker.selectedRowInComponent(0)]]
        let numCredits = stepperOutlet.value
        let courseYear = year.selectedSegmentIndex;
        var newCourse = Course(name: name, grade: grade!, numCredits: numCredits, year: courseYear)
        courses.append(newCourse);
        switch(newCourse.year) {
        case 0:
            freshmanYear.append(newCourse)
            break;
        case 1:
            sophomoreYear.append(newCourse)
            break;
        case 2:
            juniorYear.append(newCourse)
            break;
        case 3:
            seniorYear.append(newCourse);
            break;
        default:
            break;
        }
        saveData();
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func saveData() -> Void {
        var data = NSMutableArray();
        for (var i = 0; i < courses.count; ++i) {
            var propertyList = courseAsPropertyList(courses[i])
            data.addObject(propertyList)
        }
        
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: COURSES)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterGradePicker.delegate = self;
        
        letterGradePicker.dataSource = self;
        
        courseNameOutlet.delegate = self;
        
        self.navigationItem.title = "Add Course"

    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Touches began test")
        courseNameOutlet.resignFirstResponder()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Data Sources
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11;
    }
    
    //Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row];
    }

    // Size the components of the UIPickerView
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    // Convert Course Class to Property List so we can append
    // to an Array then persist that array
    func courseAsPropertyList(newCourse: Course) -> NSMutableDictionary {
        var propertyList = NSMutableDictionary();
        propertyList.setValue(newCourse.name, forKey: COURSE_NAME)
        propertyList.setValue(newCourse.grade, forKey: COURSE_GRADE)
        propertyList.setValue(newCourse.numCredts, forKey: NUM_CREDITS)
        propertyList.setValue(newCourse.year, forKey: COURSE_YEAR)
        return propertyList
    }

    // Dismiss keyboard after pressing enter
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        courseNameOutlet.resignFirstResponder()
        return true
    }
    

    
    // Convert each course in courses as a property List

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
