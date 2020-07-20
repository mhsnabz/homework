//
//  CartVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
private let cellID = "id"
class CartVC: UIViewController {
    var currentUser : CurrentUser!
   var collectionview: UICollectionView!
    let titleLbl : UILabel = {
          let lbl = UILabel()
          lbl.text = "Alışverişi Tamamla"
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
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
        configureCollectionView()
      
    }
    func configureCollectionView()  {
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
               collectionview.dataSource = self
               collectionview.delegate = self
               collectionview.backgroundColor = .white
               collectionview.register(CartCell.self, forCellWithReuseIdentifier: cellID)
               view.addSubview(collectionview)
               collectionview.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 10, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
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
    
 

}
extension CartVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CartCell
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
}
