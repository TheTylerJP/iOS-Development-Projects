//
//  SaveHealthDataViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/25/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import HealthKit

class SaveHealthDataViewController: UIViewController {

    public let healthStore = HKHealthStore()
    
    @IBOutlet weak var saveButton: UIButton!
    var percentMultiplier:Double = 1.0
    var weight:Double = 0.0
    var calories:Double = 0.0
    var fat:Double = 0.0
    var satFat:Double = 0.0
    var sodium:Double = 0.0
    var sugar:Double = 0.0
    var carbs:Double = 0.0
    var protein:Double = 0.0
    
    var iPhoneWeight:Double? {
        didSet {
            if let iPhoneWeight = iPhoneWeight {
                percentMultiplier = iPhoneWeight / weight
                print("Weight: " + String(weight))
                print("IPhone Weight: " + String(iPhoneWeight))
                print(percentMultiplier)
            } else {
                percentMultiplier = 1.0
            }
        }
    }
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var satFatLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    
    
    
    
    @IBAction func saveToHealthKit(_ sender: Any) {
        writeToKit()
    }
    

    func writeToKit() {
        let date = Date()
        let caloriesSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryEnergyConsumed)!, quantity: HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: self.calories), start: date, end: date)
        
        let fatSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryFatTotal)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.fat), start: date, end: date)
        
        let satFatSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryFatSaturated)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.satFat), start: date, end: date)
        
        let sodiumSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietarySodium)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.sodium), start: date, end: date)
        
        let sugarSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietarySugar)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.sugar), start: date, end: date)
        
        let carbsSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryCarbohydrates)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.carbs), start: date, end: date)
        
        let proteinSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryProtein)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.protein), start: date, end: date)
        
        let nutritionalData = [caloriesSample, fatSample, satFatSample, sodiumSample, sugarSample, carbsSample, proteinSample]
        
        
        healthStore.save(nutritionalData) { (success, error) in
            if let error = error {
                print(error)
            } else {
                print("success: \(success)")
            }
        }
        
        
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Updated Information"
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.cornerRadius = 4.0
        // Do any additional setup after loading the view.
        calories *= percentMultiplier
        fat *= percentMultiplier
        satFat *= percentMultiplier
        sodium *= percentMultiplier
        sugar *= percentMultiplier
        carbs *= percentMultiplier
        protein *= percentMultiplier
        
        
        caloriesLabel.attributedText = attributedText(withString: " Total Calories: " + String(describing: self.calories) + " calories.", boldString: " Total Calories: ", font: UIFont.systemFont(ofSize: 17))
        
        fatLabel.attributedText = attributedText(withString: " Total Fat: " + String(describing: self.fat) + " grams.", boldString: " Total Fat: ", font: UIFont.systemFont(ofSize: 17))
        
        satFatLabel.attributedText = attributedText(withString: " Total Saturated Fat: " + String(describing: self.satFat) + " grams.", boldString: " Total Saturated Fat: ", font: UIFont.systemFont(ofSize: 17))
        
        sodiumLabel.attributedText = attributedText(withString: " Total Sodium: " + String(describing: self.sodium), boldString: " Total Sodium: ", font: UIFont.systemFont(ofSize: 17))
        
        sugarLabel.attributedText = attributedText(withString: " Total Sugar: " + String(describing: self.sugar) + " grams.", boldString: " Total Sugar: ", font: UIFont.systemFont(ofSize: 17))
        
        carbsLabel.attributedText = attributedText(withString: " Total Carbs: " + String(describing: self.carbs) + " grams.", boldString: " Total Carbs: ", font: UIFont.systemFont(ofSize: 17))
        
        proteinLabel.attributedText = attributedText(withString: " Total Protein: " + String(describing: self.protein) + " grams.", boldString: " Total Protein: ", font: UIFont.systemFont(ofSize: 17))
        
        if HKHealthStore.isHealthDataAvailable() {
            print("Yes, HealthKit is Available")
            let healthManager = HealthKitSetupAssistant()
            healthManager.requestPermission()
        } else {
            print("There is a problem accessing HealthKit")
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: font])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
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
