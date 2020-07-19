//
//  CurrentUser.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
class CurrentUser  {
    var name : String?
    var uid : String?
    var email : String?
    var addres : String?
    var city : String?
    
    init(dic : Dictionary<String,Any>) {
        if let name = dic["name"] as? String{
            self.name = name
        }
        if let uid = dic["uid"] as? String{
            self.uid = uid
        }
        if let email = dic["email"] as? String{
            self.email = email
        }
        if let city = dic["city"] as? String{
            self.city = city
        }
        if let addres = dic["addres"] as? String{
            self.addres = addres
        }
        
    }
}
