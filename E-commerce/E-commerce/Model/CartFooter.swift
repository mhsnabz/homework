//
//  CartFooter.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 21.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class CartFooter: UICollectionViewCell {
    var delegate : CartFooterDelegate?
    let btn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Ödeme Yap", for: .normal)
        btn.clipsToBounds = true
        btn.titleLabel?.font = UIFont(name: Utilities.font, size: 14)
        btn.setBackgroundColor(color: .red, forState: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        btn.anchor(top: nil, left: nil, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 200, heigth: 35)
        btn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        btn.addTarget(self, action: #selector(odemeYap), for: .touchUpInside)
            
        
    }
    
    @objc func odemeYap(){
        delegate?.odemeYap(for : self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
