//
//  SecondViewController.swift
//  UserForm
//
//  Created by cloud-wise on 10/12/2022.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    var infoText: [String: Any] = [:]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textView.text = toString(dict: infoText)
    }
    

    // Converts the Dictionary to a String
    private func toString(dict: [String:Any])->String
    {
        var temp = ""
        for (key,value) in dict
        {
            temp += "\(key) = " + "\(value)\n"
        }
        return temp
    }

}
