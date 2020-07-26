//
//  ShoesCell.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 19.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class ShoesCell: UICollectionViewCell {
    let img : UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let name : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    let value : UILabel = {
        let lbl = UILabel()
               lbl.font = UIFont(name: Utilities.font, size: 14)
               lbl.textColor = .mainColor()
               return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(img)
        addSubview(name)
        addSubview(value)
        name.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, rigth: nil, marginTop: 8, marginLeft: 8, marginBottom: 8, marginRigth: 8, width: 0, heigth: 0)
          value.anchor(top: nil, left: nil, bottom: bottomAnchor, rigth: rightAnchor, marginTop: 8, marginLeft: 8, marginBottom: 8, marginRigth: 8, width: 0, heigth: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
