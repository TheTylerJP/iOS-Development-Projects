//
//  InitialViewController.swift
//  Dice Game
//
//  Created by Tommy Bojanin on 2/13/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    @IBOutlet weak var numSides: UILabel!
    
    @IBOutlet weak var sideIncrement: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func sidePicker(_ sender: Any) {
        numSides.text = String(sideIncrement.value)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGame" {
            let destination = segue.destination as? ViewController
            destination?.typeOfDice = Int(sideIncrement.value)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
