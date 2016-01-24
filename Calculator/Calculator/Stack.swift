//
//  Stack.swift
//  Calculator
//
//  Created by Mohan Dhar on 1/23/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

import Foundation

struct Stack<Element> {

    var items = [Element]()
    
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() {
        items.popLast();
    }

    func top() -> Element {
        return items[items.count - 1];
    }
    
    func empty() -> Bool {
        return items.count == 0;
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}