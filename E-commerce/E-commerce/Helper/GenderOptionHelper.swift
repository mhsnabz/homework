//
//  GenderOptionHelper.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import Foundation
enum GenderHelper : Int ,CustomStringConvertible {
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
  
}
