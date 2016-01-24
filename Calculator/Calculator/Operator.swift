//
//  Operator.swift
//  Calculator
//
//  Created by Mohan Dhar on 1/23/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

import Foundation

struct Operator : Hashable {
    
    var charOperator: Character;
    var precedence: Int;
    var associativity: String;
    
    init(op: Character, prec: Int, assoc: String) {
        self.charOperator = op;
        self.precedence = prec;
        self.associativity = assoc;
    }
    
    init(op: Character) {
        self.charOperator = op;
        precedence = 0;
        associativity = "";
    }
    
    // Implement this and equtable so that I can store Operators in a Set for O(1) access
    var hashValue : Int { get { return self.charOperator.hashValue } }

}

func ==(lhs: Operator, rhs: Operator) -> Bool {
    return lhs.hashValue == rhs.hashValue
}