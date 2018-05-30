//
//  ViewController.swift
//  Segue Demo
//
//  Created by Tommy Bojanin on 2/6/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToSecondPage"){
            print("Hello")
            let destination = segue.destination as? secondViewController;
            destination?.input = "gotcha"
        }
        
    }


}

