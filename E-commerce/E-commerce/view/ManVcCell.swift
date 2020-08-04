//
//  ManVcCell.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class ManVcCell: UICollectionViewCell {
    
    let name : UILabel = {
        let lbl = UILabel()
        lbl.text = "Ayakkabı"
        lbl.font = UIFont(name: Utilities.fontBold, size: 14)
        lbl.textColor = .darkGray
        
        return lbl
    }()
    
    let img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var v : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.backgroundColor = UIColor(displayP3Red: 245, green: 245, blue: 245, alpha: 1)
        
        view.addSubview(name)
        name.anchor(top: view.topAnchor, left: nil, bottom: nil, rigth: nil, marginTop: 8, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 15)
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(img)
        img.anchor(top: name.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 15, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(v)
        v.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, rigth: rightAnchor, marginTop: 10, marginLeft: 10, marginBottom: 10, marginRigth: 10, width: 0, heigth: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
