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
    
    var list : AddToCart?{
        didSet{
            print("set")
        }
    }
    var delegate : CartCellDelegate?
    
    let price : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .mainColor()
        return lbl
    }()
    let img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        return img
    }()
    let line : UIView = {
        let v = UIView()
        v.backgroundColor = .mainColorTransparent()
        return v
    }()
    let deleteButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "delete"), for: .normal)
        return btn
    }()
    
    let itemName : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .black
        return lbl
    }()
    let itemType : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    let gender : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    let type  : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(img)
        
        addSubview(deleteButton)
        deleteButton.anchor(top: nil, left: nil, bottom: nil, rigth: rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 12, width: 20, heigth: 20)
        deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(price)
        price.anchor(top: nil, left: nil, bottom: nil, rigth: deleteButton.leftAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 12, width: 0, heigth: 16)
        price.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(line)
        line.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, rigth: rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0.4)
        
        let stackType = UIStackView(arrangedSubviews: [gender,type,itemType])
        stackType.alignment = .leading
        stackType.axis = .horizontal
        stackType.spacing = 1.75
        
        
        let stack = UIStackView(arrangedSubviews: [itemName,stackType])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: nil, left: img.rightAnchor, bottom: nil, rigth: price.leftAnchor, marginTop: 0, marginLeft: 8, marginBottom: 0, marginRigth: 8, width: 0, heigth: 0)
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
    }
    @objc func deleteItem(){
        delegate?.removeItem(for : self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
