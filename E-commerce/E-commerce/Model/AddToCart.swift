//
//  AddToCart.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import Foundation
class AddToCart {
    var name : String!
    var number : Double!
    var value : Double!
    var id : String!
    var productType : String!
    var type : String!
    var gender : String!
    var thumbImage : String!
    
    init(id : String , dic : Dictionary<String,Any>) {
        self.id = id
        if let name = dic["name"] as? String{
            self.name = name
        }
        if let number = dic["number"] as? Double{
            self.number = number
        }
        if let value = dic["value"] as? Double{
            self.value = value
        }
        if let type = dic["type"] as? String{
            self.type = type
        }
        if let gender = dic["gender"] as? String{
            self.gender = gender
        }
        if let thumbImage = dic["thumbImage"] as? String{
            self.thumbImage = thumbImage
        }
        if let productType = dic["productType"] as? String{
                  self.productType = productType
              }
        
        
    }
    
}
