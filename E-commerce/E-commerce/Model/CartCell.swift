//
//  CartCell.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell
{
    
    let img : UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
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
