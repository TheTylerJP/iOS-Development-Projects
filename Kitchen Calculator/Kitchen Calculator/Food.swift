//
//  Food.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/6/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

private let apiKey:String = "bAABebg8UDkbCsGXka4F"

public enum FoodError: Error {
    case invalidJSON
}



class Food {
    
    var barcode:String = "hi"
    let productId:String
    let title:String
    let description:String
    let imageURL:String
    let price:String
    
    let properties:JSON
    let healthnotes:String
    let weight:String
    
    init?(json:JSON) {
        self.productId = json["productId"].stringValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.imageURL = json["image"].stringValue
        self.price = json["price"].stringValue
        self.properties = json["properties"]
        self.healthnotes = json["healthnotes"].stringValue
        self.weight = json["weight"].stringValue
    }
    

    static func getFoodItem (barcode:String, completion: @escaping (Food?, Error?) -> ()) {
        //let url = URL(string:"http://supermarketownbrandguide.co.uk/api/newfeed.php?json=barcode&q={" + barcode + "}&apikey={" + apiKey + "}")
        
        let url = URL(string: "http://supermarketownbrandguide.co.uk/api/newfeed.php")
        
        let params: [String : Any] = ["json" : "barcode",
                                      "q" : barcode,
                                      "apikey" : apiKey
        ]
        
        request(url!, method: .get, parameters: params).responseJSON { (response) in
            if let data = response.data {
                let json = JSON(data)
                //print(json)
                
                if let food = Food(json: json){
//                    print("JSON:")
                    print(json)
//                    print("food properties:")
//                    print(food.properties)
                    completion(food, nil)
                } else {
                    
                    completion(nil, FoodError.invalidJSON)
                }
            }
        }
    }
        
        

    /*
    static func getJSON (barcode:String, completion: @escaping (JSON?, Error?) -> ()) {
        print("getJSON was called")
        //let url = URL(string:"http://supermarketownbrandguide.co.uk/api/newfeed.php?json=barcode&q={" + barcode + "}&apikey={" + apiKey + "}")
        
        let url = URL(string: "http://supermarketownbrandguide.co.uk/api/newfeed.php")
        
        let params: [String : Any] = ["json" : "barcode",
                                      "q" : barcode,
                                      "apikey" : apiKey
        ]
        
        request(url!, method: .get, parameters: params).responseJSON { (response) in
            if let data = response.data {
                let json = JSON(data)
                //self.jsonData = json
                //print(json)
                if let food = Food(json: json){
                    completion(json, nil)
                } else {
                    
                    completion(nil, FoodError.invalidJSON)
                }
            }
        }
    }
    */
    
    
}
