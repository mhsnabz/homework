//
//  ManVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
private let manCell = "manCell"
class ManVC: UIViewController {
    
    var currentUser : CurrentUser!
    
    let titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "ERKEK"
        lbl.font = UIFont(name: Utilities.font, size: 15)
        lbl.textColor = .white
        return lbl
    }()
    let dissmisButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        
        return btn
    }()
    lazy var headerBar : UIView = {
        let v = UIView()
        v.backgroundColor = .menuColor()
        v.addSubview(dissmisButton)
        dissmisButton.anchor(top: nil, left: v.leftAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 20, marginBottom: 0, marginRigth: 0, width: 20, heigth: 20)
        dissmisButton.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        v.addSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        titleLbl.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        return v
    }()
    var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
    }
    
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(headerBar)
        headerBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 60)
        dissmisButton.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
    }
    @objc func dissmis(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = .white
        collectionview.register(ManVcCell.self, forCellWithReuseIdentifier: manCell)
        view.addSubview(collectionview)
        collectionview.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
    }
    
    
}
extension ManVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: manCell, for: indexPath) as! ManVcCell
        let menuOption = manVcOption(rawValue: indexPath.row)
        cell.img.image = menuOption?.image
        cell.name.text = menuOption?.description 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 10)/2, height: (self.view.frame.size.height)/3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductVC()
        let menuOption = manVcOption(rawValue: indexPath.row)
   
        if menuOption?.description == "Ayakkabı"{
            vc.titleText = "Erkek Ayakkabı"
            vc.typeModel = "shoes"
            vc.type = "shoes"
            
        }else  if menuOption?.description == "Pantolon"{
            vc.titleText = "Erkek Pantolon"
            vc.typeModel = "pantolon"
            vc.type = "pantolon"
        }
        else  if menuOption?.description == "T-Shirt"{
            vc.titleText = "Erkek T-Shirt"
            vc.typeModel = "tshirt"
            vc.type = "tshirt"
        }
        else  if menuOption?.description == "Eşofmanlar"{
            vc.titleText = "Erkek Eşofman"
            vc.typeModel = "gym"
            vc.type = "gym"
        }else  if menuOption?.description == "Şortlar"{
            vc.titleText = "Erkek Şortlar"
            vc.typeModel = "sortlar"
            vc.type = "sortlar"
        }
        else  if menuOption?.description == "Formalar"{
            vc.titleText = "Erkek Formalar"
            vc.typeModel = "formalar"
            vc.type = "formalar"
        }else{
            vc.titleText = "Erkek Çeket"
            vc.typeModel = "ceketler"
            vc.type = "ceketler"
        }
        vc.gender = "man"
        vc.currentUser = currentUser
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
