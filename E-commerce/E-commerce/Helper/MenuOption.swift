//
//  MenuOption.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//
import UIKit
enum MenuOption : Int ,CustomStringConvertible {
    case man
    case woman
    case kid
    var description: String{
        switch self {
        case .kid:
            return "Çocuk"
        case .woman :
            return "Kadın"
        case.man:
            
            return "Erkek"
        
        }
    }
    var image : UIImage {
        switch self {
        case .man : return UIImage(named: "male")!
        case .kid : return UIImage(named: "kid")!
        case.woman : return UIImage(named: "female")!
     
        }
    }
}
