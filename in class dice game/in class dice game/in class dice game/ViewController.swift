//
//  ViewController.swift
//  in class dice game
//
//  Created by Tommy Bojanin on 2/8/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var firstDice: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func rollDice(_ sender: Any) {
        
        UIView.animate(withDuration: 1.5) {
            self.firstDice.alpha = 0
            
        }
        
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.updateDice), userInfo: nil, repeats: false)
        
        updateDice()
        
        
    }
    
    @objc func updateDice() {
        firstDice.image = UIImage(named:"dice_2")
        UIView.animate(withDuration: 1.5) {
            self.firstDice.alpha = 1
            self.firstDice.transform = CGAffineTransform(rotationAngle: CGFloat((25 * .pi ) / 100.0))
            
        }
    }
    
    
}

