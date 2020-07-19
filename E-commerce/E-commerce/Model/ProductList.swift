//
//  ProductList.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 19.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import Foundation
class ProductList{
    
    var image : String?
    var name : String?
    var number : String?
    var thumbImage : String?
    var value : Double?
    var id : String?
    init(id : String , dic : Dictionary<String,Any>) {
        self.id = id
        if let name = dic["name"] as? String{
            self.name = name
        }
        if let image = dic["image"] as? String{
            self.image = image
        }
        if let number = dic["number"] as? String{
            self.number = number
        }
        if let thumbImage = dic["thumbImage"] as? String{
            self.thumbImage = thumbImage
        }
        if let value = dic["value"] as? Double{
            self.value = value
        }
}
}
