//
//  ViewController.swift
//  DiceRollWatchOS
//
//  Created by Tommy Bojanin on 4/3/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    @IBOutlet weak var diceSegmentControl: UISegmentedControl!
    @IBOutlet weak var rollAmountLabel: UILabel!
    var watchSession:WCSession?
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("session error.")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive error.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate error.")
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        watchSession?.sendMessage(["DiceType4" : "4", "DiceType6" : "6"], replyHandler: nil, errorHandler: nil)
    }
    
    
    
    @IBAction func rollDiceButton(_ sender: Any) {
        var diceType = diceSegmentControl.selectedSegmentIndex
        if diceType == 0 {
            diceType = 4
        } else {
            diceType = 6
        }
        let roll = String(Int(arc4random_uniform(UInt32(diceType)) + 1))
        rollAmountLabel.text = roll
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            self.watchSession = WCSession.default
            self.watchSession?.delegate = self
            self.watchSession?.activate()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

