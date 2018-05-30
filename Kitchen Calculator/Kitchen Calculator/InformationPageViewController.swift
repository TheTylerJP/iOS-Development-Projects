//
//  InformationPageViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/7/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

import SwiftyJSON
import AlamofireImage
import Alamofire

class InformationPageViewController: UIViewController {
    
    var counter:Int = 0
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    var caloriesAmount:Double?
    @IBOutlet weak var fatLabel: UILabel!
    var fatAmount:Double?
    @IBOutlet weak var satFatLabel: UILabel!
    var satFatAmount:Double?
    @IBOutlet weak var sodiumLabel: UILabel!
    var SodiumAmount:Double?
    @IBOutlet weak var sugarLabel: UILabel!
    var sugarAmount:Double?
    @IBOutlet weak var carbsLabel: UILabel!
    var carbsAmount:Double?
    
    @IBOutlet weak var proteinLabel: UILabel!
    var proteinAmount:Double?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    

    
    var jsonData:JSON?
    
    var barcode:String? {
        didSet{
            if let barcode = barcode {
                Food.getFoodItem(barcode: barcode) { (foodItem, error) in
                    self.foodItem = foodItem
                    
                }
            }
        }
    }
    
    //perform UI changes
    var foodItem: Food? {
        didSet {
            
            //loading screen while it does everything.
            /*
            let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            //presentViewController(alert, animated: true, completion: nil)
            */
            
            titleLabel.text = (foodItem?.title)!
            titleLabel.numberOfLines = 0
            
            
            
            
            //nutritional information
            
            
            
            request((foodItem?.imageURL)!, method: .get).responseImage { response in
                
                
                if let image = response.result.value {
                    self.foodImage.image = image
                    
                    print(self.foodItem?.weight)
                    //CALORIES
                    if self.foodItem?.properties["energy"] == JSON.null {
                        self.caloriesLabel.attributedText = self.attributedText(withString: " Total Calories: 0.0", boldString: " Total Calories: ", font: UIFont.systemFont(ofSize: 17))
                        self.caloriesAmount = 0.0
                    } else {
                        
                    self.caloriesAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.self.getDigits((self.foodItem?.properties["energy"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["energy"]["amount"].stringValue)!)! ) / 100
                        
                    self.caloriesLabel.attributedText = self.attributedText(withString: " Total Calories: " + String(describing: self.caloriesAmount!) + " calories.", boldString: " Total Calories: ", font: UIFont.systemFont(ofSize: 17))
                    }
                    
                    
                    //FAT
                    if self.foodItem?.properties["fat"] == JSON.null {
                        self.fatLabel.attributedText = self.attributedText(withString: " Total Fat: 0.0g", boldString: " Total Fat: ", font: UIFont.systemFont(ofSize: 17))
                        self.fatAmount = 0.0
                    } else {
                    
                        self.fatAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.getDigits((self.foodItem?.properties["fat"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["fat"]["amount"].stringValue)!)! ) / 100
                        
                        self.fatLabel.attributedText = self.attributedText(withString: " Total Fat: " + String(describing: self.fatAmount!) + " grams.", boldString: " Total Fat: ", font: UIFont.systemFont(ofSize: 17))
                    }
                    //SATURATED FAT
                    if self.foodItem?.properties["satfat"] == JSON.null {
                        self.satFatLabel.attributedText = self.attributedText(withString: " Total Saturated Fat: 0.0g", boldString: " Total Saturated Fat: ", font: UIFont.systemFont(ofSize: 17))
                        self.satFatAmount = 0.0
                    } else {
                        self.satFatAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.getDigits((self.foodItem?.properties["satfat"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["satfat"]["amount"].stringValue)!)! ) / 100
                        
                        self.satFatLabel.attributedText = self.attributedText(withString: " Total Saturated Fat: " + String(describing: self.satFatAmount!) + " grams.", boldString: " Total Saturated Fat: ", font: UIFont.systemFont(ofSize: 17))
                    }
                    
                    //SODIUM
                    if self.foodItem?.properties["sodium"] == JSON.null {
                        
                        self.sodiumLabel.attributedText = self.attributedText(withString: " Total Sodium: 0.0g", boldString: " Total Sodium: ", font: UIFont.systemFont(ofSize: 17))
                        self.SodiumAmount = 0.0
                    } else {
                        self.SodiumAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.getDigits((self.foodItem?.properties["sodium"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["sodium"]["amount"].stringValue)!)! ) / 100
                        
                        self.sodiumLabel.attributedText = self.attributedText(withString: " Total Sodium: " + String(describing: self.SodiumAmount!) + " grams.", boldString: " Total Sodium: ", font: UIFont.systemFont(ofSize: 17))
                    }
                    
                    //SUGAR
                    if self.foodItem?.properties["sugar"] == JSON.null {
                        self.sugarLabel.attributedText = self.attributedText(withString: " Total Sugar: 0.0g", boldString: " Total Sugar: ", font: UIFont.systemFont(ofSize: 17))
                        self.sugarAmount = 0.0
                    } else {
                        self.sugarAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.getDigits((self.foodItem?.properties["sugar"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["sugar"]["amount"].stringValue)!)! ) / 100
                        
                        self.sugarLabel.attributedText = self.attributedText(withString: " Total Sugar: " + String(describing: self.sugarAmount!) + " grams.", boldString: " Total Sugar: ", font: UIFont.systemFont(ofSize: 17))
                    }
                    
                    //CARBS
                    if self.foodItem?.properties["carbs"] == JSON.null {
                        self.carbsLabel.attributedText = self.attributedText(withString: " Total Carbs: 0.0g", boldString: " Total Carbs: ", font: UIFont.systemFont(ofSize: 17))
                        self.carbsAmount = 0.0
                    } else {
                        self.carbsAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.getDigits((self.foodItem?.properties["carbs"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["carbs"]["amount"].stringValue)!)! ) / 100
                        
                        self.carbsLabel.attributedText = self.attributedText(withString: " Total Carbs: " + String(describing: self.carbsAmount!) + " grams.", boldString: " Total Carbs: ", font: UIFont.systemFont(ofSize: 17))
                    }
                    
                    //PROTEIN
                    if self.foodItem?.properties["protein"] == JSON.null   {
                        
                        self.proteinLabel.attributedText = self.attributedText(withString: " Total Protein: 0.0g", boldString: " Total Protein: ", font: UIFont.systemFont(ofSize: 17))
                        self.proteinAmount = 0.0
                    } else {
                        self.proteinAmount = round(100 * (self.getDigits((self.foodItem?.weight)!) / self.getDigits((self.foodItem?.properties["protein"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["protein"]["amount"].stringValue)!)! ) / 100
                        
                        self.proteinLabel.attributedText = self.attributedText(withString: " Total Protein: " + String(describing: self.proteinAmount!) + " grams.", boldString: " Total Protein: ", font: UIFont.systemFont(ofSize: 17))
                    }
                } else {
                    self.foodImage.image = UIImage(named: "Error")!
                    self.titleLabel.text = "No product Information found."
                    self.continueButton.isHidden = true
                }
            }
            //TODO
          //  alert.dismiss(animated: false, completion: nil)
          //  alert.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product Information"
        
//        //food Image styling
//        foodImage.layer.borderColor = UIColor.black.cgColor
//        foodImage.layer.borderWidth = 2.0
//        foodImage.layer.cornerRadius = 4.0
//
//        //all Label styling
//        titleLabel.layer.borderColor = UIColor.black.cgColor
//        titleLabel.layer.borderWidth = 1.0
//        titleLabel.layer.cornerRadius = 1.0
        
        continueButton.layer.borderColor = UIColor.black.cgColor
        continueButton.layer.borderWidth = 2.0
        continueButton.layer.cornerRadius = 4.0
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func continueButton(_ sender: Any) {
        if self.getDigits((self.foodItem?.weight)!) > 385 {
         performSegue(withIdentifier: "toSaveDataPage", sender: self)
        } else {
            print("toScale")
            performSegue(withIdentifier: "toScale", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("segue was called")
        if segue.identifier == "toScale" {
            let destination = segue.destination as? ScaleViewController
            
            //sending all information over to the scale view Controller
            destination?.weight = self.getDigits((self.foodItem?.weight)!)
            destination?.calories = self.caloriesAmount!
            destination?.fat = self.fatAmount!
            destination?.satFat = self.satFatAmount!
            destination?.sodium = self.SodiumAmount!
            destination?.sugar = sugarAmount!
            destination?.carbs = carbsAmount!
            destination?.protein = proteinAmount!
            
        } else {
            let destination = segue.destination as? SaveHealthDataViewController
            
            destination?.weight = self.getDigits((self.foodItem?.weight)!)
            destination?.calories = self.caloriesAmount!
            destination?.fat = self.fatAmount!
            destination?.satFat = self.satFatAmount!
            destination?.sodium = self.SodiumAmount!
            destination?.sugar = sugarAmount!
            destination?.carbs = carbsAmount!
            destination?.protein = proteinAmount!
            
            
        }
       
    }
    
    func getDigits(_ str:String) -> Double{
        if str.isEmpty {return 0.0}
        var newString = str
        newString.removeLast()
        counter+=1
        return Double(newString)!
        
        
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


