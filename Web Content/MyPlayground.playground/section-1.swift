// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground";
var anotherStr = "Rob";

var thirdStr = str + anotherStr;

for ch in str {
    println(ch);
    
}

var newString = "Test String" as NSString

var subString = (str as NSString).substringToIndex(3);

var endingString = newString.substringWithRange(NSRange(location: 5, length: 4));

if newString.containsString("Test") {
    // Do something
}