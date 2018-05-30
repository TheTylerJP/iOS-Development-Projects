//
//  ViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 2/26/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit


class ScaleViewController: UIViewController {

    @IBOutlet weak var zeroScaleButton: UIButton!
    @IBOutlet weak var outputWeight: UILabel!
    @IBOutlet weak var goButton: UIButton!
    
    
    var itemWeight:Double = 0.0
    var weight:Double = 0.0
    var calories:Double = 0.0
    var fat:Double = 0.0
    var satFat:Double = 0.0
    var sodium:Double = 0.0
    var sugar:Double = 0.0
    var carbs:Double = 0.0
    var protein:Double = 0.0
    
    var currentForce:CGFloat! = 0
    var tareForce:CGFloat! = 0
    
    @IBOutlet weak var amountOfGrams: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Scale"
        view.isMultipleTouchEnabled = true
        //zero scale button styling
        zeroScaleButton.layer.borderColor = UIColor.black.cgColor
        zeroScaleButton.layer.borderWidth = 2.0
        zeroScaleButton.layer.cornerRadius = 4.0
        
        //output weight label styling
        outputWeight.layer.borderColor = UIColor.black.cgColor
        outputWeight.layer.borderWidth = 2.0
        outputWeight.layer.cornerRadius = 4.0
        
        goButton.layer.borderColor = UIColor.black.cgColor
        goButton.layer.borderWidth = 2.0
        goButton.layer.cornerRadius = 4.0
        
        //outputWeight.sizeToFit()
        //outputWeight.numberOfLines = 0
        outputWeight.text = "0.00 grams"
        print(calories)
    }
    
    @IBAction func zeroScale(_ sender: Any) {
        tareForce = currentForce
        outputWeight.text = "0.00 grams"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("segue was called")
        if segue.identifier == "fromScaleToSave" {
            let destination = segue.destination as? SaveHealthDataViewController
            destination?.weight = self.weight
            destination?.calories = self.calories
            destination?.fat = self.fat
            destination?.satFat = self.satFat
            destination?.sodium = self.sodium
            destination?.sugar = self.sugar
            destination?.carbs = self.carbs
            destination?.protein = self.protein
            destination?.iPhoneWeight = Double(amountOfGrams.text!)!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        
        currentForce = touch!.force/(touch?.maximumPossibleForce)!
        outputWeight.text = String(describing: round( 100 * (currentForce * 385) - (tareForce * 385))  / 100) + " grams"
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        
        currentForce = touch!.force/(touch?.maximumPossibleForce)!
        outputWeight.text = String(describing: round( 100 * (currentForce * 385) - (tareForce * 385)) / 100) + " grams"
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentForce = 0
        outputWeight.text = String(describing: round( 100 * (currentForce * 385) - (tareForce * 385))  / 100) + " grams"
    }
    
}

extension CGFloat {
    func grams(tare: CGFloat) -> String {
        print(tare)
        return String(format: "%.2f", (self - tare) / CGFloat(0.0166666))
    }
}

