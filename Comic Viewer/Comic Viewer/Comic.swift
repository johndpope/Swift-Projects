//
//  Comic.swift
//  Comic Viewer
//
//  Created by Mohan Dhar on 9/22/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import Foundation
import UIKit

class Comic : NSObject {

    var id : Int
    var month : String
    var year : String
    var day : String
    var title : String
    var img : UIImage
    
    
    
    init(comicID : Int, month : String, year : String, day : String, title : String, img : UIImage) {
        self.id = comicID
        self.month = month
        self.year = year
        self.day = day
        self.title = title
        self.img = img
    }
    

    
}