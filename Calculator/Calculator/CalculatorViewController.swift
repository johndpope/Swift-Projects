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
        let infix = "5 + ((1 + 2) * 4) - 3";
        
        let postfix = infixToPostfix(infix);
        print(infix);
        print(postfix);
        print(evaluatePostfix(postfix));
        

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
                
                // Find the last character of the postfix string and see if it's an operator
                // If it isn't, add a space after it to differentiate between the numbers in the postfix string
                let lastIndex = postfix.endIndex.advancedBy(-1);
                if (!operators.contains(Operator(op:postfix[lastIndex]))) {
                    postfix += " ";
                }
                operatorStack.push(currentOperator);
                
            }
            
            else if (char == "(") {
                operatorStack.push(Operator(op: "("));
            }
            
            else if (char == ")") {
                while (operatorStack.top().charOperator != "(") {
                    postfix.append(operatorStack.top().charOperator);
                    operatorStack.pop();
                    
                    // Mismatched parenthesis error
                    assert(!operatorStack.empty());
                }
                
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

    
    func evaluatePostfix(postfix: String) -> Double {
        var stack = Stack<Double>()

        var currentNum = "";
        for char in postfix.characters {
            if (char == " ") {
                // Make sure we can convert the current number to an Int
                assert(Double(currentNum) != nil);
                
                stack.push(Double(currentNum)!);
                currentNum = "";
            } else {
                if numbers.contains(char) {
                    currentNum.append(char);
                } else {
                    if let num = Double(currentNum) {
                        stack.push(num);
                        currentNum = ""
                    }
                    
                    // Make sure atleast 2 operands are in the stack
                    assert(stack.count >= 2);
                    
                    let second = stack.top();
                    stack.pop();
                    
                    let first = stack.top();
                    stack.pop();
                    
                    stack.push(findResult(char, first: first, second: second));
                    
                }
                
            }
        }
        // Need to make sure stack size is 1 otherwise input has too many values
        assert(stack.count == 1)
        return stack.top();
    }
    
    func findResult( op: Character, first: Double, second: Double) -> Double {
        var result: Double = 0.0;
        switch(op) {
            case "+":
                result = first + second;
                break;
            case "-":
                result = first - second;
                break;
            case "*":
                result = first * second;
                break;
            case "/":
                result = first / second;
                break;
            case "^":
                result = pow(first, second);
                break;
        default:
            print("We shouldn't be here");
        }
        return result;
    }

}
