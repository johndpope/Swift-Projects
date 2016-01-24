//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Mohan Dhar on 1/23/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    // Set of numbers for O(1) access
    let numbers: Set<Character> = Set(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]);
    
    var operators: Set<Operator> = Set();
    
    var displayString: String = "0"
    var evaluationString: String = "0"
    var lastCharacter: Character = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load all operators
        let add = Operator(op: "+", prec: 2, assoc: "Left");
        let subtract = Operator(op: "-", prec: 2, assoc: "Left");
        let multiply = Operator(op: "*", prec: 3, assoc: "Left");
        let divide = Operator(op: "/", prec: 3, assoc: "Left");
        let exponent = Operator(op: "^", prec: 4, assoc: "Right");
        let negate = Operator(op: "~", prec: 5, assoc: "Right");
        let modulo = Operator(op: "%", prec: 3, assoc: "Left")
        
        
        operators.insert(add);
        operators.insert(subtract);
        operators.insert(multiply);
        operators.insert(divide);
        operators.insert(exponent);
        operators.insert(negate);
        operators.insert(modulo);
        

        // Do any additional setup after loading the view.
        let infix = "~3 - ~4";
        
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
                if (!postfix.isEmpty) {
                    let lastIndex = postfix.endIndex.advancedBy(-1);
                    if (!operators.contains(Operator(op:postfix[lastIndex]))) {
                        postfix += " ";
                    }
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
                    if (char == "~") {
                        assert(stack.count >= 1);
                        stack.push(1);
                    } else {
                        assert(stack.count >= 2);
                    }
                    
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
            case "~":
                result = -first;
        default:
            print("We shouldn't be here");
        }
        return result;
    }
    
    
    func createEvaluationString(char: Character) {
        if (displayString == "0") {
            displayString = "";
            evaluationString = "";
        }
        
        // Can't have two operators in a row
        if (operators.contains(Operator(op: char)) &&
        operators.contains(Operator(op: lastCharacter))) {
            
            displayString = displayString.substringToIndex(displayString.endIndex.predecessor());

            evaluationString = evaluationString.substringToIndex(evaluationString.endIndex.predecessor());
        }
        
        switch (char) {
            case "*":
                displayString.append("x" as Character);
                break;
            case "/":
                displayString.append("÷" as Character);
                break;
            
            default:
                displayString.append(char);
        }
        evaluationString.append(char);
        lastCharacter = char;
        resultLabel.text = displayString;
        
        print(evaluationString);
        print(displayString);
    }
    
    // MARK: ALL BUTTONS
    
    // C
    @IBAction func clear(sender: UIButton) {
        evaluationString = "0";
        displayString = "0";
        resultLabel.text = displayString;
    }
    
    // ( )
    @IBAction func parenthesis(sender: UIButton) {
    }
    
    // %
    @IBAction func modulo(sender: UIButton) {
        createEvaluationString("%");
    }
    
    // ÷
    @IBAction func division(sender: UIButton) {
        createEvaluationString("/");
    }
    
    // X
    @IBAction func multiply(sender: UIButton) {
        createEvaluationString("*");
    }
    
    // -
    @IBAction func subtract(sender: UIButton) {
        createEvaluationString("-");
    }
    
    // +
    @IBAction func add(sender: UIButton) {
        createEvaluationString("+");
    }
    
    // =
    @IBAction func equals(sender: UIButton) {
        let infix = evaluationString;
        let postfix = infixToPostfix(infix);
        let result = evaluatePostfix(postfix);
        displayString = "\(result)";
        evaluationString = "\(result)";
        self.resultLabel.text = "\(result)";
    }
    
    // +/-
    @IBAction func negate(sender: UIButton) {
        
    }

    // .
    @IBAction func decimal(sender: UIButton) {
    }
    
    // 0
    @IBAction func zero(sender: UIButton) {
        createEvaluationString("0");
    }
    
    // 1
    @IBAction func one(sender: UIButton) {
        createEvaluationString("1");
    }
    
    // 2
    @IBAction func two(sender: UIButton) {
        createEvaluationString("2");
    }
    
    // 3
    @IBAction func three(sender: UIButton) {
        createEvaluationString("3");
    }
    
    // 4
    @IBAction func four(sender: UIButton) {
        createEvaluationString("4");
    }
    
    // 5
    @IBAction func five(sender: UIButton) {
        createEvaluationString("5");
    }
    
    // 6
    @IBAction func six(sender: UIButton) {
        createEvaluationString("6");
    }
    
    // 7
    @IBAction func seven(sender: UIButton) {
        createEvaluationString("7");
    }
    
    // 8
    @IBAction func eight(sender: UIButton) {
        createEvaluationString("8");
    }
    
    // 9
    @IBAction func nine(sender: UIButton) {
        createEvaluationString("9");
    }



}
