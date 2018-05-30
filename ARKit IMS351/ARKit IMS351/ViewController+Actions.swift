//
//  ViewController+Actions.swift
//  ARKit IMS351
//
//  Created by Tommy Bojanin on 5/8/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import SceneKit

extension ViewController {
    
    enum SegueIdentifier: String {
        case showSettings
    }
    
    func restartExperience() {
    
    //printing out for debugging purposes
    DispatchQueue.main.async {
    self.textManager.cancelAllScheduledMessages()
    self.textManager.dismissPresentedAlert()
    self.textManager.showMessage("STARTING A NEW SESSION")
    
    self.virtualObjectManager.removeAllVirtualObjects()
    self.focusSquare?.isHidden = true
    
    self.resetTracking()
        // Show the focus square after a short delay to ensure all plane anchors have been deleted.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.setupFocusSquare()
        })
    
    

    }
    }

    
   
    
    
}
