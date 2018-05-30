//
//  InterfaceController.swift
//  Dice Rolling for IMS 351 WatchKit Extension
//
//  Created by Kuhn, Artie R Mr. on 4/3/18.
//  Copyright © 2018 artiekuhn. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var watchSession: WCSession!
    var diceType = 0
    
    public func session(_ session: WCSession, activationDidCompleteWith    activationState: WCSessionActivationState, error: Error?) {
        print ("error in activationDidCompleteWith error")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        diceType = (message["diceType"]! as? Int)!
        diceRollResultLabel.setText(String(diceType))
    }
    
    
    
    @IBOutlet var diceRollResultLabel: WKInterfaceLabel!
    
    @IBAction func rollDiceButton() {
        if(diceType == 0) {
            diceType = 4
        }else if(diceType == 1) {
            diceType = 6
        }
        var roll = String(Int(arc4random_uniform(UInt32(diceType))+1))
        
        diceRollResultLabel.setText(roll)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(WCSession.isSupported()) {
            self.watchSession = WCSession.default
            self.watchSession.delegate = self
            self.watchSession.activate()
        }
    }
    
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
