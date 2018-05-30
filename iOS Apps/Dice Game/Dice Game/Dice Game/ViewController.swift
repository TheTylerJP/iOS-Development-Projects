//
//  ViewController.swift
//  Dice Game
//
//  Created by Tommy Bojanin on 2/1/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var typeOfDice:Int = 0
    
    @IBOutlet weak var firstDice: UIImageView!
    @IBOutlet weak var secondDice: UIImageView!
    

    @IBOutlet weak var numbersRolled: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button action functions
    @IBAction func rollDice(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 1.5) {
            self.firstDice.alpha = 0
            self.secondDice.alpha  = 0
        }
        
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.updateDice), userInfo: nil, repeats: false)
        
        updateDice()
        
        
        
    }
    
    @objc func updateDice() {
        let num1:Int = Int(arc4random_uniform(UInt32(typeOfDice))+1)
        let num2:Int = Int(arc4random_uniform(UInt32(typeOfDice))+1)
        
        firstDice.image = UIImage(named:"dice_"+String(num1))
        secondDice.image = UIImage(named:"dice_"+String(num2))
        
        UIView.animate(withDuration: 1.5, animations: {
            
            let rand1:Int = Int(arc4random_uniform(100))
            let rand2:Int = Int(arc4random_uniform(100))

            self.firstDice.transform = CGAffineTransform(rotationAngle: CGFloat(Float((rand1)) / 180.0))
            self.secondDice.transform = CGAffineTransform(rotationAngle: CGFloat(Float((rand2)) / 180.0))
            self.firstDice.alpha = 1.0
            self.secondDice.alpha = 1.0
        })
        
        //outputString.text =  phrase(dice1: num1, dice2: num2)
    }
    
    //Generates the phrase from the dice
    func phrase(dice1: Int, dice2: Int ) -> String{
       
        if(dice1 == 1) {
            
            if(dice2==1) {return "Snake Eyes!"}
            else if(dice2 == 2) {return "Australian yo!"}
            else if(dice2 == 3) {return "Little joe from kokomo!"}
            else if(dice2 == 4) {return "No field five!"}
            else if(dice2 == 5) {return "Easy six!"}
            else {return "Six one your done!"}
            
        } else if (dice1 == 2) {
            
            if(dice2==1) {return "Ace caught a deuce!"}
            else if(dice2 == 2) {return "Ballerina!"}
            else if(dice2 == 3) {return "The fever!"}
            else if(dice2 == 4) {return "Jimmie hicks!"}
            else if(dice2 == 5) {return "Benny Blue!"}
            else {return "Easy eight!"}
            
        } else if (dice1 == 3) {
            
            if(dice2==1) {return "Easy four"}
            else if(dice2 == 2) {return "OJ!"}
            else if(dice2 == 3) {return "Brooklyn Forest!"}
            else if(dice2 == 4) {return "Big red!"}
            else if(dice2 == 5) {return "Eighter from decatur!"}
            else {return "Nina from Pasadena!"}
            
        } else if (dice1 == 4) {
            
            if(dice2==1) {return "Little Phoebe!"}
            else if(dice2 == 2) {return "Easy Six!"}
            else if(dice2 == 3) {return "Skinny McKinney!"}
            else if(dice2 == 4) {return "Square Pair!"}
            else if(dice2 == 5) {return "Railroad Nine!"}
            else {return "Big one on the end!"}
            
        } else if (dice1 == 5) {
            
            if(dice2==1) {return "Sixie From Dixie!"}
            else if(dice2 == 2) {return "Skinny Dugan!"}
            else if(dice2 == 3) {return "Easy Eight!"}
            else if(dice2 == 4) {return "Jessy James!"}
            else if(dice2 == 5) {return "Puppy paws!"}
            else {return "yo!"}
            
        } else {
            if(dice2==1) {return "The devil!"}
            else if(dice2 == 2) {return "Easy eight!"}
            else if(dice2 == 3) {return "Lou Brown!"}
            else if(dice2 == 4) {return "Tennessee!"}
            else if(dice2 == 5) {return "Six Five no Jive!"}
            else {return "Midnight!"}
        }
        

    }
    

}

