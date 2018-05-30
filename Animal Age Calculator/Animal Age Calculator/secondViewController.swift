//
//  secondViewController.swift
//  Animal Age Calculator
//
//  Created by Tommy Bojanin on 2/8/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    var age = 0, name = "default"
    var food = "default", chooseSize = 0, chooseAnimal = 0
    @IBOutlet weak var typedName: UILabel!
    @IBOutlet weak var typedAge: UILabel!
    @IBOutlet weak var animalFood: UIImageView!
    @IBOutlet weak var foodDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typedName.numberOfLines = 0
        foodDescription.numberOfLines = 0
        //Logic statements
        if chooseAnimal == 0 {// dog
            if age < 1 {
                typedName.text = name + " should be eating Puppy Chow."
                animalFood.image = UIImage(named: "puppyChow")
                foodDescription.text = "This food is intended for puppies."
            } else if (age >= 1 && age <= 8) && chooseSize == 1 {
                typedName.text = name + " should be eating Large Chunk Chow."
                animalFood.image = UIImage(named: "largeChunkChow")
                foodDescription.text = "This food is intended for mid-age large dogs."
            } else if (age >= 1 && age <= 8) && chooseSize == 0 {
                typedName.text = name + " should be eating Small Chunk Chow."
                animalFood.image = UIImage(named: "smallChunkChow")
                foodDescription.text = "This food is intended for mid-age small dogs."
            } else {
                 typedName.text = name + " should be eating Chow Mush for old dogs."
                animalFood.image = UIImage(named: "dogChowMush")
                foodDescription.text = "This food is intended for old dogs."
            }
            typedAge.text = String(age * 7)
                
            
            
            
        } else if chooseAnimal == 1 {
            if age < 2 {
                typedName.text = name + "  should be eating Kitty Wet Food."
                animalFood.image = UIImage(named: "kittyWetFood")
                foodDescription.text = "This food is intended for kittens."
            } else if (age >= 2 && age <= 11) && chooseSize == 1 {
                typedName.text = name + " should be eating two servings of Cat Wet Food."
                animalFood.image = UIImage(named: "catWetFood")
                foodDescription.text = "This food is intended for large mid-age cats."
            } else if (age >= 2 && age <= 11) && chooseSize == 0 {
                typedName.text = name + " should be eating one serving of Cat Wet Food."
                animalFood.image = UIImage(named: "catWetFood")
                foodDescription.text = "This food is intended for small mid-age cats."
            } else {
                typedName.text = name + " should be eating Cat Mush for Old Cats."
                animalFood.image = UIImage(named: "catMush")
                foodDescription.text = "This food is intended for old cats."
            }
            typedAge.text = String(age * 5)
            
        } else { // goldfish
            if chooseSize == 0 {
                typedName.text = name + " should be eating one pinch of Fish Flakes per day."
                animalFood.image = UIImage(named: "fishFlakes")
                foodDescription.text = "This food is intended for small goldfish."
            } else {
                typedName.text = name + " should be eating three pinches of Fish Flakes per day."
                animalFood.image = UIImage(named: "fishFlakes")
                foodDescription.text = "This food is intended for large goldfish."
            }
            
            typedAge.text = String(Int(arc4random_uniform(60)) * age)
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
