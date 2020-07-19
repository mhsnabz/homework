//
//  SingleProductCell.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class SingleProductCell: UICollectionViewCell
{
    let img : UIImageView = {
          let img = UIImageView()
           img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "logo")
           return img
       }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(img)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
