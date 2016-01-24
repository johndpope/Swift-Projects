//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Mohan Dhar on 1/23/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

import UIKit

extension String {
    // If the string is empty this will return a null character
    mutating func pop() -> Character {
        if !(self.isEmpty) {
            let index = self.endIndex.predecessor();
            let char = self.removeAtIndex(index);
            return char;
        }
        let empty: Character = "\0";
        return empty;
    }
    
    func back() -> Character {
        if !(self.isEmpty) {
            let index = self.endIndex.predecessor();
            return self[index];
        }
        let empty: Character = "\0";
        return empty;
    }
}

class CalculatorViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    // Set of numbers for O(1) access
    let numbers: Set<Character> = Set(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]);
    
    var operators: Set<Operator> = Set();
    
    var displayString: String = "0";
    var evaluationString: String = "0";
    var lastCharacter: Character = "0";
    
    var isResult: Bool = false;
    
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
                    if (postfix.back() != " " && !operators.contains(Operator(op:postfix.back()))) {
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
        if (stack.count != 1) {
            if let originalNum = Double(postfix) { return originalNum }
        }
        // assert(stack.count == 1)
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
            if (operators.contains(Operator(op: char))) {
                return;
            }
            displayString = "";
            evaluationString = "";
        }
        
        // Negation is a special case
        if (char == "~") {
            
            // If last character is an operator, negate the next number, else: negate the previous number
            if (!operators.contains(Operator(op: lastCharacter))) {
                var evaluationStack = Stack<Character>()

                
                // Keep popping from evaluation string until it is empty or you reach another operator
                // MARK: Check for parenthesis
                while (!evaluationString.isEmpty && (evaluationString.back() == "~" || !operators.contains(Operator(op:evaluationString.back())))) {
                    evaluationStack.push(evaluationString.pop());
                }

                // Reconstruct the evaluation string with the negation
                evaluationString.append("~" as Character)
                if (evaluationStack.top() == "~") {
                    evaluationString.pop();
                    evaluationStack.pop();
                }
                while (!evaluationStack.empty()) {
                    // If the top of the stack is a negation, you don't need to append another negation
                    evaluationString.append(evaluationStack.top());
                    evaluationStack.pop();
                }
            } else {
                
            }
            
            displayString = "";
            for element in evaluationString.characters {
                displayString.append(displayChar(element));
                //print("Display String: \(displayString)");
            }

            resultLabel.text = displayString;
            return;
        }
        
            
        // Can't have two operators in a row
        else if (operators.contains(Operator(op: char)) &&
        operators.contains(Operator(op: lastCharacter))) {
            print("Can't have two operators in a row");
            displayString.pop();
            evaluationString.pop();
        }
        
        displayString.append(displayChar(char));
        evaluationString.append(char);
        lastCharacter = char;
        resultLabel.text = displayString;
        
        print(displayString);
        print(evaluationString);
        
    }
    
    func displayChar(char: Character) -> Character {
        var returnChar = char;
        switch (char) {
            case "*":
                returnChar = "×" as Character;
                break;
            case "/":
                returnChar = "÷" as Character;
                break;
            case "~", "-":
                returnChar = "-" as Character;
                break;
            case "+":
                returnChar = "+" as Character;
                break;
                        
            default:
                break;
                // print("Do nothing")
        }
        return returnChar;
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
        
        // Set isResult flag so that if keys are pressed after a result is evaluated, they are not concatenated to the result
        isResult = true;
        displayString = "\(result)";
        evaluationString = "\(result)";
        self.resultLabel.text = "\(result)";
    }
    
    // +/-
    @IBAction func negate(sender: UIButton) {
        createEvaluationString("~")
        
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
