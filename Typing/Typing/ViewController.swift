//
//  ViewController.swift
//  Typing
//
//  Created by user on 14.06.17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var text1: UITextView!
    
    @IBOutlet weak var text2: UITextView!
    
    var ref: DatabaseReference!
    
    var a = ""
    
    var b = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
        text1.delegate = self
        text1.becomeFirstResponder()
        
        Auth.auth().signInAnonymously() { (user, error) in
            if (error == nil) {
                
            }else{
                print(error)
            }
        }
        
        getScndUsersText()
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        print(text1.text); //the textView parameter is the textView where text was changed
        
        self.ref.child("first").setValue(text1.text)
    }
    
    func getScndUsersText(){
        self.ref.child("second").observe(DataEventType.value, with: { (snapshot) in
            if (snapshot.value != nil){
            let value = snapshot.value as? String
            print(value as Any)
            self.text2.text = value
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

