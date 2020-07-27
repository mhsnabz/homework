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
