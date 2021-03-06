//
//  MenuOptionManVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
enum manVcOption : Int ,CustomStringConvertible {
    case ayakkabi
    case pantolon
    case ceketler
    case tshirt
    case gym
    case sortlar
    case formalar
    
    
    
    var description: String{
        switch self {
        case .ayakkabi:
            return "Ayakkabı"
        case .pantolon :
            return "Pantolon"
        case.tshirt:
            return "T-Shirt"
        case .gym:
            return "Eşofmanlar"
        case .sortlar:
            return "Şortlar"
        case .formalar:
            return "Formalar"
        case .ceketler:
            return "Çeketler"
            
        }
    }
    var image : UIImage {
        switch self {
        case .ayakkabi : return UIImage(named: "ayakkabi")!
        case .pantolon : return UIImage(named: "pantolon")!
        case.tshirt : return UIImage(named: "tshirt")!
        case .ceketler : return UIImage(named: "ceketler")!
        case .formalar: return UIImage(named: "formalar")!
        case .gym: return UIImage(named: "gym")!
        case .sortlar : return UIImage(named :"sortlar")!
        }
    }
}
enum womanVcOption : Int ,CustomStringConvertible {
    case ayakkabi
    case pantolon
    case ceketler
    case tshirt
    case gym
    case sortlar
    case formalar
    
    
    
    var description: String{
        switch self {
        case .ayakkabi:
            return "Ayakkabı"
        case .pantolon :
            return "Pantolon"
        case.tshirt:
            return "T-Shirt"
        case .gym:
            return "Eşofmanlar"
        case .sortlar:
            return "Şortlar"
        case .formalar:
            return "Formalar"
        case .ceketler:
            return "Çeketler"
            
        }
    }
    var image : UIImage {
        switch self {
        case .ayakkabi : return UIImage(named: "woman-shoes")!
        case .pantolon : return UIImage(named: "woman-jean")!
        case.tshirt : return UIImage(named: "woman-tshirt")!
        case .ceketler : return UIImage(named: "woman-jacket")!
        case .formalar: return UIImage(named: "woman-forma")!
        case .gym: return UIImage(named: "woman-gym")!
        case .sortlar : return UIImage(named :"woman-sort")!
        }
    }
}
enum kidVcOption : Int ,CustomStringConvertible {
    case ayakkabi
    case pantolon
    case ceketler
    case tshirt
    case gym
    case sortlar
    case formalar
    
    
    
    var description: String{
        switch self {
        case .ayakkabi:
            return "Ayakkabı"
        case .pantolon :
            return "Pantolon"
        case.tshirt:
            return "T-Shirt"
        case .gym:
            return "Eşofmanlar"
        case .sortlar:
            return "Şortlar"
        case .formalar:
            return "Formalar"
        case .ceketler:
            return "Çeketler"
            
        }
    }
    var image : UIImage {
        switch self {
        case .ayakkabi : return UIImage(named: "kid-shoes")!
        case .pantolon : return UIImage(named: "kid-jean")!
        case.tshirt : return UIImage(named: "kid-tshirt")!
        case .ceketler : return UIImage(named: "kid-jacket")!
        case .formalar: return UIImage(named: "kid-forma")!
        case .gym: return UIImage(named: "kid-gym")!
        case .sortlar : return UIImage(named :"kid-sort")!
        }
    }
}
