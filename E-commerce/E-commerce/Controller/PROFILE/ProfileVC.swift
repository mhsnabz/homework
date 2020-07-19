//
//  ProfileVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class ProfileVC: UIViewController {

    var currentUser : CurrentUser!{
        didSet{
         
            self.nameLbl.text = currentUser.name
            self.email.text = currentUser.email
            print("addres " + currentUser.addres!)
            print("city " + currentUser.city!)
            
        }
    }
 
    let titleLbl : UILabel = {
       let lbl = UILabel()
        lbl.text = "PROFİL"
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
        
        view.addSubview(nameHeader)
        nameHeader.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 4, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 30)
        
        view.addSubview(nameLbl)
        nameLbl.anchor(top: nameHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: nil, marginTop: 8,marginLeft: 8, marginBottom: 0, marginRigth: 0, width: 0, heigth: 16)
        view.addSubview(email)
          email.anchor(top: nameLbl.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: nil, marginTop: 8,marginLeft: 8, marginBottom: 0, marginRigth: 0, width: 0, heigth: 16)
        
        view.addSubview(addressHeader)
         addressHeader.anchor(top: email.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 16, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 30)
        view.addSubview(address)
        address.anchor(top: addressHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 8,marginLeft: 8, marginBottom: 0, marginRigth: 45, width: 0, heigth: 0)
        view.addSubview(addressEdit)
        addressEdit.anchor(top: nil, left: address.rightAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 0, marginLeft: 5, marginBottom: 0, marginRigth: 5, width: 30, heigth: 30)
        addressEdit.centerYAnchor.constraint(equalTo: address.centerYAnchor).isActive = true
        setAddress()
        
        let stack = UIStackView(arrangedSubviews: [waitOrders,oldOrders])

        stack.axis = .horizontal
        stack.alignment = .center

        stack.distribution = .fillEqually
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: address.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 30, marginLeft: 20, marginBottom: 20, marginRigth: 20, width: 0, heigth: 50)
       

    }
    

    override func viewWillAppear(_ animated: Bool) {
     
    }
    private func setAddress(){
        let db = Firestore.firestore().collection("user")
            .document(Auth.auth().currentUser!.uid)
        db.addSnapshotListener { (docSnap, err) in
            if err == nil {
                self.currentUser = CurrentUser.init(dic: docSnap!.data()!)
                let addres = self.currentUser.addres
                let city = self.currentUser.city
                self.address.text = addres! + "\n" + city!
            }
        }
        
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
    
    let nameHeader : UILabel = {
        let lbl = UILabel()
        lbl.text = "Hesap Bilgileri"
        lbl.font = UIFont(name: Utilities.fontBold, size: 16)
        lbl.backgroundColor = UIColor(white: 0.95, alpha: 0.7)
        lbl.clipsToBounds = true
        lbl.textAlignment = .left
        lbl.textColor = .black
        return lbl
    }()
    let nameLbl : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.textColor = .black
        return lbl
    }()
    let email : UILabel = {
           let lbl = UILabel()
          lbl.font = UIFont(name: Utilities.font, size: 14)
          lbl.textColor = .black
          return lbl
    }()
    let addressHeader : UILabel = {
           let lbl = UILabel()
           lbl.text = "Adres Bilgileri"
           lbl.font = UIFont(name: Utilities.fontBold, size: 16)
           lbl.backgroundColor = UIColor(white: 0.95, alpha: 0.7)
           lbl.clipsToBounds = true
           lbl.textAlignment = .left
           lbl.textColor = .black
           return lbl
       }()
    
    
    let address : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: Utilities.font, size: 14)
        lbl.text = "Mustafa Kemal Mah. 544/1 Sokak Işıl Apart no : 12 Daire : 1 \n İskenderun / HATAY"
        lbl.textColor = .black
        return lbl
    }()
    
    let addressEdit : UIButton = {
        let btn = UIButton ()
        btn.setImage(UIImage(named: "edit"), for: .normal)
        btn.addTarget(self, action: #selector(editAddress), for: .touchUpInside)
        return btn
    }()
    
    
    let waitOrders : UIButton = {
        let btn = UIButton()
        btn.setTitle("Bekleyen Siparişler", for: .normal)
        btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 13)!
                 btn.layer.cornerRadius = 10
           btn.setTitleColor(.white, for: .normal)
        //                 btn.addTarget(self, action: #selector(loginPage), for: .touchUpInside)
        btn.backgroundColor = UIColor.mainColor()
        return btn
    }()
    let oldOrders : UIButton = {
        let btn = UIButton()
        btn.setTitle("Tamamlanan Siparişler", for: .normal)
        btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 13)!
        //                   btn.addTarget(self, action: #selector(loginPage), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(.white, for: .normal)
        
        btn.backgroundColor = UIColor.mainColor()
        return btn
    }()
    
    
    //MARK: - handlers
    @objc func editAddress(){
        let vc = EditAdress()
        vc.currentUser = currentUser
        self.present(vc, animated: true, completion: nil)
    }

}
