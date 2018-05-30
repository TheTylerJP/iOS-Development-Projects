//
//  Plane.swift
//  ARKit IMS351
//
//  Created by Tommy Bojanin on 5/7/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//
//  ********This file was provided by apple during WWDC 2017********
import Foundation
import ARKit

class Plane: SCNNode {
    
    // MARK: - Properties
    
    var anchor: ARPlaneAnchor
    var focusSquare: FocusSquare?
    
    // MARK: - Initialization
    
    init(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARKit
    
    func update(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
    }
    
}
