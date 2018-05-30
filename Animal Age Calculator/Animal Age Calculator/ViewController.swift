//
//  ViewController.swift
//  Animal Age Calculator
//
//  Created by Tommy Bojanin on 2/1/18.
//  Copyright © 2018 TommyBojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var animalAge: UIDatePicker!
    @IBOutlet weak var chooseSize: UISegmentedControl!
    @IBOutlet weak var chooseAnimal: UISegmentedControl!
    @IBOutlet weak var animalName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "secondVC" {
            let destination = segue.destination as? secondViewController
            
            let year = Calendar.current.component(.year, from: animalAge.date)
            let currentYear = Calendar.current.component(.year, from: Date())
            destination?.age  = currentYear - year
            destination?.chooseAnimal = chooseAnimal.selectedSegmentIndex
            destination?.chooseSize = chooseSize.selectedSegmentIndex
            destination?.name = animalName.text!
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

