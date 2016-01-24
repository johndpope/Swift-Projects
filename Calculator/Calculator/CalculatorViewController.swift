//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Mohan Dhar on 1/23/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    // Set of numbers for O(1) access
    let numbers: Set<Character> = Set(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]);
    
    var operators: Set<Operator> = Set();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load all operators
        let add = Operator(op: "+", prec: 2, assoc: "Left");
        let subtract = Operator(op: "-", prec: 2, assoc: "Left");
        let multiply = Operator(op: "*", prec: 3, assoc: "Left");
        let divide = Operator(op: "/", prec: 3, assoc: "Left");
        let exponent = Operator(op: "^", prec: 4, assoc: "Right");
        
        operators.insert(add);
        operators.insert(subtract);
        operators.insert(multiply);
        operators.insert(divide);
        operators.insert(exponent);
        

        // Do any additional setup after loading the view.
        let infix = "(300 + 23) * (43 - 21) / (84 + 7)";
        
        let postfix = infixToPostfix(infix);
        print(infix);
        print(postfix);
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Method to convert from infix to postfix using the Shunting-yard algorithm
    func infixToPostfix(infix: String) -> String {
        var postfix = "";
        var operatorStack = Stack<Operator>();
        
        for char in infix.characters {
            if numbers.contains(char) {
                postfix.append(char);
            }
            
            else if (operators.contains(Operator(op: char))) {
                let indexOfOperator = operators.indexOf(Operator(op: char))!
                let currentOperator = operators[indexOfOperator];
                
                while (!operatorStack.empty() &&
                ((currentOperator.associativity == "Left" && currentOperator.precedence <= operatorStack.top().precedence) ||
                (currentOperator.associativity == "Right" && currentOperator.precedence < operatorStack.top().precedence))) {
                    postfix.append(operatorStack.top().charOperator);
                    operatorStack.pop();
                }
                
                operatorStack.push(currentOperator);
                
            }
            
            else if (char == "(") {
                operatorStack.push(Operator(op: "("));
            }
            
            else if (char == ")") {
                while (operatorStack.top().charOperator != "(" && !operatorStack.empty()) {
                    postfix.append(operatorStack.top().charOperator);
                    operatorStack.pop();
                }
                
                // Mismatched parenthesis error
                assert(!operatorStack.empty());
                
                // Pop the "(" from the stack
                operatorStack.pop();
                
            }
            
        }
        
        // No more characters to read
        // Operator stack is not empty
        print(operatorStack);
        while (!operatorStack.empty()) {
            
            // Mismatched parenthesis error
            
            assert(operatorStack.top().charOperator != "(" && operatorStack.top().charOperator != ")")
            postfix.append(operatorStack.top().charOperator);
            operatorStack.pop();
        }
        
        return postfix;
    }

    
    func evaluatePostfix(postfix: String) {

        
    }

}
