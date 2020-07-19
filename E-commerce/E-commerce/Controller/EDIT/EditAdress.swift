//
//  EditAdress.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 19.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import FirebaseFirestore
class EditAdress: UIViewController {

    var currentUser : CurrentUser!
    
    let titleLbl : UILabel = {
       let lbl = UILabel()
        lbl.text = "Adresinizi Güncelleyin"
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
    let lblAddress : UILabel = {
        let lbl = UILabel ()
        lbl.font = UIFont(name: Utilities.fontBold, size: 14)
        lbl.text = "Mah - Sokak - Numara"
        return lbl
    }()
    let lblCity : UILabel = {
           let lbl = UILabel ()
           lbl.font = UIFont(name: Utilities.fontBold, size: 14)
           lbl.text = "İlçe / İl"
           return lbl
       }()
    let address : UITextView = {
          let txt = UITextView()
        
           txt.layer.borderWidth = 0.3
           txt.dataDetectorTypes = .all
           txt.layer.borderColor = UIColor.lightGray.cgColor
           txt.isSelectable = true
           txt.text = String(txt.text.prefix(140))
           return txt
       }()
    let city : UITextView = {
            let txt = UITextView()
          
             txt.layer.borderWidth = 0.3
             txt.dataDetectorTypes = .all
             txt.layer.borderColor = UIColor.lightGray.cgColor
             txt.isSelectable = true
             txt.text = String(txt.text.prefix(140))
             return txt
         }()
   
    let save : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Kaydet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 16)!
        
        
        return btn
    }()
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(headerBar)
        headerBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 60)
        dissmisButton.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
        view.addSubview(lblAddress)
        lblAddress.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 8, marginLeft: 20, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        view.addSubview(address)
        address.anchor(top: lblAddress.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 8, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        address.delegate = self
        address.isScrollEnabled = false
        
        textViewDidChange(address)
        view.addSubview(lblCity)
        lblCity.anchor(top: address.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: nil, marginTop: 12, marginLeft: 20, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        
        
        view.addSubview(city)
        city.anchor(top: lblCity.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 8, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 30)
        
        view.addSubview(save)
        save.anchor(top: city.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 40, marginLeft: 70, marginBottom: 40, marginRigth: 70, width: 0, heigth: 50)
        Utilities.styleFilledButton(save)
        save.addTarget(self, action: #selector(saveFunc), for: .touchUpInside)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    
        
     
    }
    
   

    //MARK: -handlers
    @objc func dissmis(){
          self.dismiss(animated: true, completion: nil)
      }
    @objc func saveFunc()
    {
        let db = Firestore.firestore().collection("user")
            .document(currentUser.uid!)
        let dic  = ["addres":address.text!,"city":city.text!] as [String:Any]
        db.setData(dic, merge: true) { (err) in
            if err == nil {
                let db = Firestore.firestore().collection("user")
                    .document(self.currentUser.uid!)
                db.getDocument { (docSnap, err) in
                    if err == nil {
                        self.currentUser = CurrentUser.init(dic: docSnap!.data()!)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
}
extension EditAdress: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: 300)
        let estimatedSize = textView.sizeThatFits(size)

       if textView.contentSize.height >= 300
       {
        textView.isScrollEnabled = true
       }
       else
           {
           textView.frame.size.height = textView.contentSize.height
            textView.isScrollEnabled = false // textView.isScrollEnabled = false for swift 4.0
       }
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {

                if textView.contentSize.height >= 300
                {
                 textView.isScrollEnabled = true
                     constraint.constant = 300
                }
                else
                    {
                    textView.frame.size.height = textView.contentSize.height
                     textView.isScrollEnabled = false // textView.isScrollEnabled = false for swift 4.0
                        constraint.constant = estimatedSize.height
                }
              //  constraint.constant = estimatedSize.height
            }
        }
    }
   
    
}
