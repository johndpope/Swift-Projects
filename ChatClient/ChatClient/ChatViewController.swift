//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Mohan Dhar on 1/23/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@IBDesignable
class MessageTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 10;
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset);
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds);
    }
}


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate {

    struct ChatItem {
        var user: String;
        var message: String;
        var timestamp: String;
        var id: Int;
        
        init(username: String, msg: String, time: String, identifier: Int) {
            self.user = username;
            self.message = msg;
            self.timestamp = time;
            self.id = identifier;
        }
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    var messages = [ChatItem]()
    var username: String = "";
    var lastSeen = 0;
    var keyboardShowing = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set scroll view size
        scrollView.contentSize = self.view.bounds.size;

        // Set tableview separators to clear color
        self.tableView.separatorColor = UIColor.clearColor();
        
        // Do any additional setup after loading the view.
        print("\(username) has entered")
        getMessages();
        registerForKeyboardNotifications();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // TableView Delegate + Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messagesIdentifier", forIndexPath: indexPath) as! ChatBubbleTableViewCell
        
        cell.messageLabel?.text = "\(messages[indexPath.row].user) : \(messages[indexPath.row].message)";
        if (self.username == messages[indexPath.row].user) {

        } else {

        }
        
        return cell;
    }
    
    
    @IBAction func sendButtonPressed(sender: UIButton) {
        send();
    }
    
    // Handle REQUESTS
    func send() {
        makePostRequest();
        clearChatBox();
        messageTextField.becomeFirstResponder();
        
    }
    
    func makePostRequest() {
        let url = "http://localhost:8000/store/get_name_and_message/";
        
        let parameters = [
            "user": username,
            "message": messageTextField.text ?? "",
        ];
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                self.getMessages();
                
        }
    }
    
    func getMessages() {
        let url = "http://localhost:8000/store/show_all_messages/"
        let parameters = [
            "id" :  self.lastSeen
        ]
        
        
        Alamofire.request(.GET, url, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    self.parseData(JSON(value));
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func parseData(json: JSON) {
        print("Parsing data\n");
        for (var i = 0; i < json.count; ++i) {
            var username: String = "";
            var msg: String = "";
            var time: String = "";
            
            if let timestamp = json[i]["fields"]["created_on"].string {
                time = timestamp
            }
            
            if let user = json[i]["fields"]["user"].string {
                username = user;
            }
            if let message = json[i]["fields"]["message"].string {
                msg = message;
            }
            
            let id: Int = json[i]["pk"].intValue;
            self.lastSeen = id;
            
            //print("\(username) said \(msg) at \(time)");
            
            let item = ChatItem(username: username, msg: msg, time: time, identifier: id);
            messages.append(item);
        }
        loadMessages();
    }
    
    
    // UTILITY Methods
    func loadMessages() {
        tableView.reloadData();
        scrollToLastMessage();
    }
    
    func scrollToLastMessage() {
        if messages.count != 0 {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: messages.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func clearChatBox() {
        // There is a bug where the chatbox moves to it's original position after setting the text
        messageTextField.text = "";
        
    }
    
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter();
        notificationCenter.addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardDidHideNotification, object: nil)
        
    }
    
    func keyboardWasShown(notification: NSNotification) {
        // Get the keyboard information

        let info: NSDictionary = notification.userInfo!;
        let keyboardSize = info.objectForKey(UIKeyboardFrameEndUserInfoKey)!.CGRectValue.size;
        
        
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
        
        
        var rect = self.view.bounds;
        rect.size.height -= keyboardSize.height;
        if (!CGRectContainsPoint(rect, self.messageTextField.frame.origin)) {
            self.scrollView.scrollRectToVisible(messageTextField.frame, animated: true);
            
        }
  
        
    }
    

    
    func keyboardWillBeHidden(notification: NSNotification) {
        
        UIView.animateWithDuration(0.04, animations: {
            let contentInsets = UIEdgeInsetsZero;
            self.scrollView.contentInset = contentInsets;
            self.scrollView.scrollIndicatorInsets = contentInsets;
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        send();
        return true;
    }



}
