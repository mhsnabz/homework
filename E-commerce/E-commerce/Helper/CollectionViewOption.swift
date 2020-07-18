//
//  CollectionViewOption.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
enum CollectionViewOption : Int ,CustomStringConvertible {
        case bir
      case iki
      case uc
      case dort
      case bes
      case alti
      
      var description: String{
          switch self {
          case .bir:
              return "1"
          case .iki :
              return "2"
          case.uc:
              return "3"
          case .dort:
              return "4"
          case .bes:
              return "5"
          case .alti:
              return "6"
          
          }
      }
      var image : UIImage {
          switch self {
          case .bir : return UIImage(named: "1")!
          case .iki : return UIImage(named: "2")!
          case.uc : return UIImage(named: "3")!
          case .dort : return UIImage(named: "4")!
          case .bes: return UIImage(named: "5")!
               case .alti: return UIImage(named: "6")!
          }
      }
}
