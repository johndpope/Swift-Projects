//
//  EditViewController.swift
//  NYU GPA
//
//  Created by Mohan Dhar on 6/4/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var courseNameOutlet: UITextField!
    @IBOutlet var letterGradePickerOutlet: UIPickerView!
    @IBOutlet var stepperOutlet: UIStepper!
    @IBOutlet var numCreditsLabel: UILabel!
    @IBOutlet var segmentOutlet: UISegmentedControl!
    
    var editCourse:Course = Course()
    var index:Int = 0;

    let pickerData = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "F"]
    let grades = [4.0 : 0, 3.7 : 1, 3.3 : 2, 3.0 : 3, 2.7 : 4, 2.3 : 5, 2.0 : 6, 1.7 : 7, 1.3 : 8, 1.0 : 9, 0.0 : 10]
    let numGrades:[String : Double] = ["A" : 4.0, "A-" : 3.7, "B+" : 3.3, "B" : 3.0, "B-" : 2.7, "C+" : 2.3, "C" : 2.0, "C-" : 1.7, "D+" : 1.3, "D" : 1.0, "F" : 0.0]
    @IBAction func stepperPressed(sender: UIStepper) {
        numCreditsLabel.text = "\(stepperOutlet.value)"
    }
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        editCourse.name = courseNameOutlet.text
        editCourse.grade = numGrades[pickerData[letterGradePickerOutlet.selectedRowInComponent(0)]]!
        editCourse.numCredts = stepperOutlet.value
        editCourse.year = segmentOutlet.selectedSegmentIndex;
        courses[index] = editCourse
        saveData()
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        letterGradePickerOutlet.delegate = self;
        letterGradePickerOutlet.dataSource = self;
    
        letterGradePickerOutlet.selectRow(grades[editCourse.grade]!, inComponent: 0, animated: true)
        courseNameOutlet.text = editCourse.name
        stepperOutlet.value = editCourse.numCredts
        numCreditsLabel.text = "\(editCourse.numCredts)"
        segmentOutlet.selectedSegmentIndex = editCourse.year

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //NSUserDefaults
    func saveData() -> Void {
        var data = NSMutableArray();
        for (var i = 0; i < courses.count; ++i) {
            var propertyList = courseAsPropertyList(courses[i])
            data.addObject(propertyList)
        }
        
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: COURSES)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func courseAsPropertyList(newCourse: Course) -> NSMutableDictionary {
        var propertyList = NSMutableDictionary();
        propertyList.setValue(newCourse.name, forKey: COURSE_NAME)
        propertyList.setValue(newCourse.grade, forKey: COURSE_GRADE)
        propertyList.setValue(newCourse.numCredts, forKey: NUM_CREDITS)
        propertyList.setValue(newCourse.year, forKey: COURSE_YEAR)
        return propertyList
    }
    
    
    //Picker View
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Size the components of the UIPickerView
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController.isKindOfClass(EditCourseViewController)) {
            var destination:EditCourseViewController = segue.destinationViewController as! EditCourseViewController
            destination.course = editCourse;
        }
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
