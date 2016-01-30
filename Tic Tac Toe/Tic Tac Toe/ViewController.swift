//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Mohan Dhar on 12/25/14.
//  Copyright (c) 2014 Mohan Dhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var x = UIImage(named: "x.png");
    var o = UIImage(named: "o.png");
    var white = UIImage(named: "white.png");
    var humanTurn:Bool = false;
    var human:[Bool] = [false, false, false, false, false, false, false, false, false];
    var machine:[Bool] = [false, false, false, false, false, false, false, false, false];

    @IBOutlet var image0: UIImageView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
    @IBOutlet var image7: UIImageView!
    @IBOutlet var image8: UIImageView!

    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    
    
    @IBOutlet var playAgainButton: UIButton!
    @IBOutlet var winLabel: UILabel!
    
    @IBAction func button0(sender: UIButton) {
        if (humanTurn) {
            human[0] = true;
            humanTurn = false;
            image0.image = x;
            button0.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
            machinePlay();
            }
        }
    }
    @IBAction func button1(sender: AnyObject) {
        if (humanTurn) {
            human[1] = true;
            humanTurn = false;
            image1.image = x;
            button1.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }
    @IBAction func button2(sender: UIButton) {
        if (humanTurn) {
            human[2] = true;
            humanTurn = false;
            image2.image = x;
            button2.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }
    @IBAction func button3(sender: UIButton) {
        if (humanTurn) {
            human[3] = true;
            humanTurn = false;
            image3.image = x;
            button3.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }
    @IBAction func button4(sender: UIButton) {
        if (humanTurn) {
            human[4] = true;
            humanTurn = false;
            image4.image = x;
            button4.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }
    @IBAction func button5(sender: UIButton) {
        if (humanTurn) {
            human[5] = true;
            humanTurn = false;
            image5.image = x;
            button5.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }
    @IBAction func button6(sender: UIButton) {
        if (humanTurn) {
            human[6] = true;
            humanTurn = false;
            image6.image = x;
            button6.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })            } else {
                machinePlay();
            }
        }
    }
    @IBAction func button7(sender: UIButton) {
        if (humanTurn) {
            human[7] = true;
            humanTurn = false;
            image7.image = x;
            button7.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }

    @IBAction func button8(sender: UIButton) {
        if (humanTurn) {
            human[8] = true;
            humanTurn = false;
            image8.image = x;
            button8.hidden = true;
            if (checkHumanWin()) {
                winLabel.hidden = false;
                winLabel.text = "You Win!";
                playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            } else {
                machinePlay();
            }
        }
    }
    
    @IBAction func playAgain(sender: UIButton) {
        image0.image = white;
        image1.image = white;
        image2.image = white;
        image3.image = white;
        image4.image = white;
        image5.image = white;
        image6.image = white;
        image7.image = white;
        image8.image = white;
        
        button0.hidden = false;
        button1.hidden = false;
        button2.hidden = false;
        button3.hidden = false;
        button4.hidden = false;
        button5.hidden = false;
        button6.hidden = false;
        button7.hidden = false;
        button8.hidden = false;

        human = [false, false, false, false, false, false, false, false, false];
        machine = [false, false, false, false, false, false, false, false, false];
        
        winLabel.text = "";
        
        viewDidLoad();
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        winLabel.hidden = true;
        playAgainButton.hidden = true;
        let num = arc4random_uniform(2);

        if (num == 1) {
            humanTurn = true;
            print("My turn");
        } else {
            print("Machine's turn");
            humanTurn = false;
            machinePlay();
        }
    
    }
    
    func checkHumanWin() -> Bool {
        var win = false;
        
        if (human[0] && human[1] && human[2]) {
            win = true;
            hideButtons();
        }
        else if (human[3] && human[4] && human[5]) {
            win = true;
            hideButtons();
        }
        else if (human[6] && human[7] && human[8]) {
            win = true;
            hideButtons();
        }
        else if (human[0] && human[3] && human[6]) {
            win = true;
            hideButtons();
        }
        else if (human[1] && human[4] && human[7]) {
            win = true;
            hideButtons();
        }
        else if (human[2] && human[5] && human[8]) {
            win = true;
            hideButtons();
        }
        else if (human[0] && human[4] && human[8]) {
            win = true;
            hideButtons();
        }
        else if (human[2] && human[4] && human[6]) {
            win = true;
            hideButtons();
        }

        return win;
    }
    
    func checkMachineWin() -> Bool {
        var win = false;
        if (machine[0] && machine[1] && machine[2]) {
            win = true;
            hideButtons();
        }
        else if (machine[3] && machine[4] && machine[5]) {
            win = true;
            hideButtons();
        }
        else if (machine[6] && machine[7] && machine[8]) {
            win = true;
            hideButtons();
        }
        else if (machine[0] && machine[3] && machine[6]) {
            win = true;
            hideButtons();
        }
        else if (machine[1] && machine[4] && machine[7]) {
            win = true;
            hideButtons();
        }
        else if (machine[2] && machine[5] && machine[8]) {
            win = true;
            hideButtons();
        }
        else if (machine[0] && machine[4] && machine[8]) {
            win = true;
            hideButtons();
        }
        else if (machine[2] && machine[4] && machine[6]) {
            win = true;
            hideButtons();
        }
        return win;
    }
    
    func hideButtons() {
        button0.hidden = true;
        button1.hidden = true;
        button2.hidden = true;
        button3.hidden = true;
        button4.hidden = true;
        button5.hidden = true;
        button6.hidden = true;
        button7.hidden = true;
        button8.hidden = true;
    }
    
    func machinePlay() {
        // println("In machinePlay()")
        if (!button0.hidden || !button1.hidden || !button2.hidden || !button3.hidden || !button4.hidden || !button5.hidden || !button6.hidden || !button7.hidden || !button8.hidden) {
            var num = Int(arc4random_uniform(9));
            while (machine[num] || human[num]) {
                num = Int(arc4random_uniform(9))
            }
            // println("machinePlay position: \(num)");
            machine[num] = true;
            if (num == 0) {
                image0.image = o;
                button0.hidden = true;
            }
            else if (num == 1) {
                image1.image = o;
                button1.hidden = true;
            }
            else if (num == 2) {
                image2.image = o;
                button2.hidden = true;
            }
            else if (num == 3) {
                image3.image = o;
                button3.hidden = true;
            }
            else if (num == 4) {
                image4.image = o;
                button4.hidden = true;
            }
            else if (num == 5) {
                image5.image = o;
                button5.hidden = true;
            }
            else if (num == 6) {
                image6.image = o;
                button6.hidden = true;
            }
            else if (num == 7) {
                image7.image = o;
                button7.hidden = true;
            }
            else if (num == 8) {
                image8.image = o;
                button8.hidden = true;
            }
            if (checkMachineWin()) {
                self.winLabel.hidden = false;
                self.winLabel.text = "Computer Wins";
                self.playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
                
            } else if (button0.hidden && button1.hidden && button2.hidden && button3.hidden && button4.hidden && button5.hidden && button6.hidden && button7.hidden && button8.hidden) {
                self.winLabel.hidden = false;
                self.winLabel.text = "Draw";
                self.playAgainButton.hidden = false;
                UIView.animateWithDuration(1.5, animations: {
                    self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                    self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
                })
            }
            else {
                humanTurn = true;
            }
            // println("My turn again");
        } else {
            self.winLabel.hidden = false;
            self.winLabel.text = "Draw";
            self.playAgainButton.hidden = false;
            UIView.animateWithDuration(1.5, animations: {
                self.winLabel.center = CGPointMake(self.winLabel.center.x + 400, self.winLabel.center.y);
                self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400, self.playAgainButton.center.y);
            })
        }
    }
    
    func checkDraw() -> Bool {
        var draw = true;
        if (!button0.hidden || !button1.hidden || !button2.hidden || !button3.hidden || !button4.hidden || !button5.hidden || !button6.hidden || !button7.hidden || !button8.hidden) {
            draw = false;
        }
        return draw;
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

