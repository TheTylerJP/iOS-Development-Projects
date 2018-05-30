//
//  InterfaceController.swift
//  DiceRollWatchOS WatchKit Extension
//
//  Created by Tommy Bojanin on 4/3/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var watchSession:WCSession?
    @IBOutlet var diceAmountLabel: WKInterfaceLabel!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
      //  diceAmountLabel.setText(<#T##text: String?##String?#>)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        diceAmountLabel.setText(message["diceType4"] as! String)
    }
    
    
    
    @IBAction func rollDice() {
        
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            self.watchSession = WCSession.default
            self.watchSession?.delegate = self
            self.watchSession?.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
