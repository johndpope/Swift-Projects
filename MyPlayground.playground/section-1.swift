// Playground - noun: a place where people can play

import UIKit

var myName = "Robert"

for x in myName {
    println(x);
}

for (index, x) in enumerate(myName) {
    println(index);
    myName[index] = x + 1;
}