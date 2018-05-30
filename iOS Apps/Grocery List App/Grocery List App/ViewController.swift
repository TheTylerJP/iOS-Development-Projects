//
//  ViewController.swift
//  Grocery List App
//
//  Created by Kuhn, Artie R Mr. on 2/12/18.
//  Copyright © 2018 artiekuhn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var savedGroceryList = [""]
    
    @IBOutlet weak var newItemField: UITextField!
    
    @IBAction func addItemButton(_ sender: Any) {
        savedGroceryList.append(newItemField.text!)
        
        newItemField.text = ""
        
        print(savedGroceryList)
        
        UserDefaults.standard.set(savedGroceryList, forKey: "SaveGroceryList")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        savedGroceryList = UserDefaults.standard.object(forKey: "SaveGroceryList") as? [String] ?? [String]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

