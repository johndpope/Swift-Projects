//
//  MessagesViewController.swift
//  ChatClient
//
//  Created by Mohan Dhar on 1/21/16.
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


class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    struct ChatItem {
        var user: String;
        var message: String;
        var timestamp: String;
        
        init(username: String, msg: String, time: String) {
            self.user = username;
            self.message = msg;
            self.timestamp = time;
        }
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    
    var messages = [ChatItem]()
    var username: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(username) has entered")
        getMessages();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: UIButton) {
        send()
    }
    
    func send() {
        makePostRequest();
        clearChatBox();
        messageTextField.becomeFirstResponder();
    }
    
    func printMessages() {
        for (var i = 0; i < messages.count; ++i) {
            print("User : \(messages[i].user) said \(messages[i].message) at \(messages[i].timestamp)\n");
        }
    }
    
    func makePostRequest() {
        let url = "http://localhost:8000/store/get_name_and_message/"
        
        let parameters = [
            "user": username,
            "message": messageTextField.text ?? ""
        ]
        
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                self.getMessages();
                
        }
    }
    
    func getMessages() {
        messages = [ ]
        let url = "http://localhost:8000/store/show_all_messages/"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
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
            
            print("\(username) said \(msg) at \(time)");
            
            let item = ChatItem(username: username, msg: msg, time: time);
            messages.append(item);
        }
        loadMessages();
    }
    
    func loadMessages() {
        tableView.reloadData();
        if messages.count != 0 {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: messages.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func clearChatBox() {
        messageTextField.text = "";
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messagesIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(messages[indexPath.row].user) : \(messages[indexPath.row].message)";
        if (self.username == messages[indexPath.row].user) {
            cell.textLabel?.textAlignment = NSTextAlignment.Right
        } else {
            cell.textLabel?.textAlignment = NSTextAlignment.Left
        }

        return cell;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        send();
        return true;
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
