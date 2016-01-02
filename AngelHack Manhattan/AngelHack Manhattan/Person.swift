//
//  Person.swift
//  AngelHack Manhattan
//
//  Created by Mohan Dhar on 7/11/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class Person : NSObject {

    var firstName : String
    var lastName : String
    var company : String
    var position : String
    var phoneNumber : String
    var email : String
    var website : String?
    var linkedIn : String?
    var twitter : String?
    var github : String?
    
    init?(first: String, last: String, comp: String, pos: String, num: String,
        eMail: String, web: String, linked: String, twit: String, git: String) {
            self.firstName = first
            self.lastName = last
            self.company = comp
            self.position = pos
            self.phoneNumber = num
            self.email = eMail
            self.website = web
            self.linkedIn = linked
            self.twitter = twit
            self.github = git
            
            super.init()
    
            if (firstName.isEmpty || lastName.isEmpty || company.isEmpty || position.isEmpty ||
                phoneNumber.isEmpty || email.isEmpty) {
                    return nil
            }
    }
    
    
    init(first: String, last: String, comp: String, pos: String, num: String,
        eMail: String, web: String) {
            self.firstName = first
            self.lastName = last
            self.company = comp
            self.position = pos
            self.phoneNumber = num
            self.email = eMail
            self.website = web
            
            super.init()
    }
    
}