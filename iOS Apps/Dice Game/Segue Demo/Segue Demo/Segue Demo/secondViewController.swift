//
//  secondViewController.swift
//  Segue Demo
//
//  Created by Tommy Bojanin on 2/6/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    
    @IBOutlet weak var output: UITextField!
    var input = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.text = input;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


