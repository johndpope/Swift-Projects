//
//  NYUTableViewController.swift
//  NYU GPA
//
//  Created by Mohan Dhar on 6/3/15.
//  Copyright (c) 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class Course {
    // Course contains name, grade, numCredits, and year
    var name:String = ""
    var grade:Double = 0.0
    var numCredts:Double = 0.0
    var year:Int = 0
    
    init (name: String, grade: Double, numCredits: Double, year:Int) {
        // var course:Course = Course(name: "", grade: 0, numCredits: 0, year: 0)
        self.name = name
        self.grade = grade;
        self.numCredts = numCredits
        self.year = year
    }
    
    init() { }
    
}

var courses:[Course] = [];
var freshmanYear:[Course] = [];
var sophomoreYear:[Course] = [];
var juniorYear:[Course] = [];
var seniorYear:[Course] = [];

class NYUTableViewController: UITableViewController {
    
    let numToLetter:[Double : String] = [4.0 : "A", 3.7 : "A-", 3.3 : "B+", 3.0 : "B", 2.7 : "B-", 2.3 : "C+", 2.0 : "C", 1.7 : "C-", 1.3 : "D+", 1.0 : "D", 0.0 : "F" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSUserDefaults.standardUserDefaults().removeObjectForKey(COURSES)
        //NSUserDefaults.standardUserDefaults().synchronize()
        
        if let data:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(COURSES) {
            if courses.count == 1 {
                courses.removeLast()
            }
            for (var i = 0; i < data.count; ++i) {
                let course = propertyListToCourse(data[i] as! NSMutableDictionary)
                courses.append(course)
                //println("Course: \(course.name) Grade: \(course.grade) NumCredits: \(course.numCredts)")
                switch(course.year) {
                case 0:
                    freshmanYear.append(course)
                    break;
                case 1:
                    sophomoreYear.append(course)
                    break;
                case 2:
                    juniorYear.append(course)
                    break;
                case 3:
                    seniorYear.append(course)
                    break;
                default:
                    break;
                }
            }
            print("Freshman: \(freshmanYear.count) Sophomore: \(sophomoreYear.count) Junior: \(juniorYear.count) Senior: \(seniorYear.count)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func viewDidAppear(animated: Bool) {
        // Refresh table data everytime we come back to this tableViewController
        tableView.reloadData()
    }
    
    func saveData() -> Void {
        // Save the data in NSUserDefaults using an array
        let data = NSMutableArray();
        for (var i = 0; i < courses.count; ++i) {
            let propertyList = courseAsPropertyList(courses[i])
            data.addObject(propertyList)
        }
        
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: COURSES)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func courseAsPropertyList(newCourse: Course) -> NSMutableDictionary {
        // Property list is an dictionary with a key for each attribute of a custom object
        let propertyList = NSMutableDictionary();
        propertyList.setValue(newCourse.name, forKey: COURSE_NAME)
        propertyList.setValue(newCourse.grade, forKey: COURSE_GRADE)
        propertyList.setValue(newCourse.numCredts, forKey: NUM_CREDITS)
        propertyList.setValue(newCourse.year, forKey: COURSE_YEAR)
        return propertyList
    }
    
    func propertyListToCourse(coursePropertyList:NSMutableDictionary) -> Course {
        // Creates an object from a property list (NSMutableDictionary)
        let name = coursePropertyList[COURSE_NAME] as! String
        let grade = coursePropertyList[COURSE_GRADE] as! Double
        let numCredits = coursePropertyList[NUM_CREDITS] as! Double
        let year = coursePropertyList[COURSE_YEAR] as! Int
        let course = Course(name: name, grade: grade, numCredits: numCredits, year: year)
        return course
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section) {
        case 0:
            return freshmanYear.count;
        case 1:
            return sophomoreYear.count;
        case 2:
            return juniorYear.count;
        case 3:
            return seniorYear.count
        default:
            break;
        }
        return 0;

        //return courses.count
}
    
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        
        var sectionName = ""
        switch(section) {
        case 0:
            sectionName = "Freshman"
            break;
        case 1:
            sectionName = "Sophomore"
            break;
        case 2:
            sectionName = "Junior"
            break;
        case 3:
            sectionName = "Senior"
            break;
        default:
            break;
        }
        return sectionName
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        //cell.textLabel?.text = "\(courses[indexPath.row].name)"
        switch(indexPath.section) {
        case 0:
            cell.textLabel?.text = "\(freshmanYear[indexPath.row].name)"
            cell.detailTextLabel?.text = "\(numToLetter[freshmanYear[indexPath.row].grade]!)"
            break;
        case 1:
            cell.textLabel?.text = "\(sophomoreYear[indexPath.row].name)"
            cell.detailTextLabel?.text = "\(numToLetter[sophomoreYear[indexPath.row].grade]!)"
            break;
        case 2:
            cell.textLabel?.text = "\(juniorYear[indexPath.row].name)"
            cell.detailTextLabel?.text = "\(numToLetter[juniorYear[indexPath.row].grade]!)"
            break;
        case 3:
            cell.textLabel?.text = "\(seniorYear[indexPath.row].name)"
            cell.detailTextLabel?.text = "\(numToLetter[seniorYear[indexPath.row].grade]!)"
            break;
        default:
            break;
        }
        cell.detailTextLabel?.textColor = UIColor.purpleColor()
        return cell
    }
    

    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row);
    }
*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Pass data after segueing
        if (segue.destinationViewController.isKindOfClass(EditCourseViewController)) {
            let destination:EditCourseViewController = segue.destinationViewController as! EditCourseViewController
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            var index:Int

            
            switch(indexPath.section) {
            case 0:
                destination.course = freshmanYear[indexPath.row]
                break;
            case 1:
                destination.course = sophomoreYear[indexPath.row]
                break;
            case 2:
                destination.course = juniorYear[indexPath.row]
                break;
            case 3:
                destination.course = seniorYear[indexPath.row]
                break
            default:
                break;
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //courses.removeAtIndex(indexPath.row)
            var remove:Course = Course()
            
            switch(indexPath.section) {
            case 0:
                remove = freshmanYear[indexPath.row]
                freshmanYear.removeAtIndex(indexPath.row)
                break;
            case 1:
                remove = sophomoreYear[indexPath.row]
                sophomoreYear.removeAtIndex(indexPath.row)
                break;
            case 2:
                remove = juniorYear[indexPath.row]
                juniorYear.removeAtIndex(indexPath.row)
                break;
            case 3:
                remove = seniorYear[indexPath.row]
                seniorYear.removeAtIndex(indexPath.row)
                break
            default:
                break;
            }
            for (var i = 0; i < courses.count; ++i) {
                if (remove.name == courses[i].name) {
                    print("\(courses[i].name) removed from courses")
                    courses.removeAtIndex(i)
                }
            }
            
            saveData()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        /*
            else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        } 
        */
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
