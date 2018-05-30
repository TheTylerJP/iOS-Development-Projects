//
//  ViewController.swift
//  Dice Rolling for IMS 351
//
//  Created by Kuhn, Artie R Mr. on 4/3/18.
//  Copyright © 2018 artiekuhn. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    @IBOutlet weak var diceTypeButton: UISegmentedControl!
    @IBAction func diceTypeButton(_ sender: Any) {
        watchSession.sendMessage(["diceType":diceTypeSegmentedControl.selectedSegmentIndex], replyHandler: nil, errorHandler: nil)
    
    }
    
    var watchSession: WCSession!
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        print ("error in sessionDidBecomeInactive")
    }
    public func sessionDidDeactivate(_ session: WCSession) {
        print ("error in SesssionDidDeactivate")
    }
    public func session(_ session: WCSession, activationDidCompleteWith    activationState: WCSessionActivationState, error: Error?) {
        print ("error in activationDidCompleteWith error")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
    }
    

    @IBOutlet weak var diceTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var rollResultLabel: UILabel!
    
    @IBAction func rollDiceButton(_ sender: Any) {
        var roll : String = ""
        var diceType = diceTypeSegmentedControl.selectedSegmentIndex
        var percentileDice:Int?
        
        switch diceType {
        case 1 : diceType = 6
        case 2 : diceType = 8
        case 3 : percentileDice = 10
        case 4 : diceType = 10
        case 5 : diceType = 12
        case 6 : diceType = 20
        default:
            diceType = 4
        }
        guard percentileDice == 10 else {
            roll = String(Int(arc4random_uniform(UInt32(diceType))+1))
            rollResultLabel.text = roll
            return
        }
        roll = String(percentileDice! * 10)
        rollResultLabel.text = roll
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(WCSession.isSupported()) {
            self.watchSession = WCSession.default
            self.watchSession.delegate = self
            self.watchSession.activate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

