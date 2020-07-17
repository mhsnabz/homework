//
//  MenuOptionCell.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    let typeImage : UIImageView = {
       let img = UIImageView()
       
        img.contentMode = .scaleAspectFit
        return img
    }()
    let name : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.text = "sample text"
        lbl.textColor = .white
        return lbl
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(typeImage)
        typeImage.anchor(top: nil, left: leftAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 8, marginBottom: 0, marginRigth: 0, width: 30, heigth: 30)
        typeImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(name)
        name.anchor(top: nil, left: typeImage.rightAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 10, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
