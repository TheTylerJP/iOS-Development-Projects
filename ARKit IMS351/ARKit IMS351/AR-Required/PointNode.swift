//
//  PointNode.swift
//  ARKit IMS351
//
//  Created by Tommy Bojanin on 5/7/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//
//  ********This file was provided by apple during WWDC 2017********

import Foundation
import SceneKit

//EDIT THESE FOR DIFFERENT SIZES OF THE POINT
//ORIGINAL Point size value: POINT_SIZE = CGFloat(0.003)
// Original Point height value: POINT_HEIGHT = CGFloat(0.00001)
let POINT_SIZE = CGFloat(0.003)
let POINT_HEIGHT = CGFloat(0.00001)


class PointNode: SCNNode {
    
    static var boxGeo: SCNBox?

    //this int assigns the type of material the user requested for the points.
    public var typeOfMaterial : Int = materialIndex

    override init() {
        super.init()
        
        if PointNode.boxGeo == nil {
            PointNode.boxGeo = SCNBox(width: POINT_SIZE, height: POINT_HEIGHT, length: POINT_SIZE, chamferRadius: 0.001)
            
            // edit the image to change the look of the point
            let material = PointNode.boxGeo!.firstMaterial
            material?.lightingModel = SCNMaterial.LightingModel.blinn
            
            switch(typeOfMaterial) {
            case 0 :
                material?.diffuse.contents  = UIImage(named: "art.scnassets/black.png")
                material?.normal.contents   = UIImage(named: "art.scnassets/black.png")
                material?.specular.contents = UIImage(named: "art.scnassets/black.png")
            case 1 :
                material?.diffuse.contents  = UIImage(named: "art.scnassets/blue.png")
                material?.normal.contents   = UIImage(named: "art.scnassets/blue.png")
                material?.specular.contents = UIImage(named: "art.scnassets/blue.png")
            case 2 :
                material?.diffuse.contents  = UIImage(named: "art.scnassets/red.png")
                material?.normal.contents   = UIImage(named: "art.scnassets/red.png")
                material?.specular.contents = UIImage(named: "art.scnassets/red.png")
            case 3 :
                material?.diffuse.contents  = UIImage(named: "art.scnassets/green.png")
                material?.normal.contents   = UIImage(named: "art.scnassets/green.png")
                material?.specular.contents = UIImage(named: "art.scnassets/green.png")
            case 4 :
                material?.diffuse.contents  = UIImage(named: "art.scnassets/yellow.png")
                material?.normal.contents   = UIImage(named: "art.scnassets/yellow.png")
                material?.specular.contents = UIImage(named: "art.scnassets/yellow.png")
                
            default:
                material?.diffuse.contents  = UIImage(named: "art.scnassets/black.png")
                material?.normal.contents   = UIImage(named: "art.scnassets/black.png")
                material?.specular.contents = UIImage(named: "art.scnassets/black.png")
            }
        }
        
        let object = SCNNode(geometry: PointNode.boxGeo!)
        object.transform = SCNMatrix4MakeTranslation(0.0, Float(POINT_HEIGHT) / 2.0, 0.0)
        
        self.addChildNode(object)
        
    }
    
    func chooseMaterial() {
        if self.typeOfMaterial == 0 {
            
        }
    }
    
    init(color: UIColor) {
        super.init()
        
        let boxGeo = SCNBox(width: POINT_SIZE, height: POINT_HEIGHT * 2.0, length: POINT_SIZE, chamferRadius: 0.001)
        boxGeo.firstMaterial?.diffuse.contents = UIColor.red
        
        let object = SCNNode(geometry: boxGeo)
        object.transform = SCNMatrix4MakeTranslation(0.0, Float(POINT_HEIGHT * 2.0) / 2.0, 0.0)
        
        self.addChildNode(object)
        
    }
    
    func setNewHeight(newHeight: CGFloat) {
        PointNode.boxGeo?.height = newHeight
        let firstChild = self.childNodes[0]
        firstChild.transform = SCNMatrix4MakeTranslation(0.0, Float(newHeight / 2.0), 0.0)
    }
    
    func resetHeight() {
        PointNode.boxGeo?.height = POINT_HEIGHT
        let firstChild = self.childNodes[0]
        firstChild.transform = SCNMatrix4MakeTranslation(0.0, Float(POINT_HEIGHT / 2.0), 0.0)
    }
    
    func getChildBoundingBox() -> (v1: SCNVector3, v2: SCNVector3) {
        let firstChild = self.childNodes[0]
        return (firstChild.boundingBox.max, firstChild.boundingBox.min)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
