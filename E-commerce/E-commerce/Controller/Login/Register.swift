//
//  Register.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 18.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import TweeTextField
import FirebaseAuth
import FirebaseFirestore
import JDropDownAlert
import SVProgressHUD

class Register: UIViewController {
    
      let labelContrackt : UILabel = {
              let label = UILabel()
               label.text = "Devam ederek"
               label.font = UIFont(name: Utilities.font, size: 12)!
               label.textAlignment = .center
               label.numberOfLines = 1
             
               return label
           }()
           let lbl : UILabel = {
                let label = UILabel()
                 label.text = "hükümlerimizi kabul ettiğinizi bildirirsiniz"
                 label.font = UIFont(name: Utilities.font, size: 12)!
                 label.textAlignment = .center
                 label.numberOfLines = 1
               
                 return label
             }()
           let lblAnd : UILabel = {
               let lbl = UILabel()
               lbl.text = " ve "
               lbl.font =  UIFont(name: Utilities.font, size: 12)!
               return lbl
           }()
           let termsOfServiceBtn : UIButton = {
           let btn = UIButton(type: .system)
           btn.titleLabel?.textColor = UIColor.mainColor()
           let text1 = NSMutableAttributedString(string: "Hizmet Şartları", attributes :[NSAttributedString.Key.font : UIFont(name: Utilities.font, size: 12)!, NSAttributedString.Key.foregroundColor:  UIColor.mainColor() ])
           btn.setAttributedTitle(text1, for: .normal)
    //           btn.addTarget(self, action: #selector(termsOfService), for: .touchUpInside)
           return btn
               
           }()
           let privacyPolicy : UIButton = {
           let btn = UIButton(type: .system)
           let text1 = NSMutableAttributedString(string: "Gizlilik Politikası", attributes :[NSAttributedString.Key.font : UIFont(name:Utilities.font, size: 12)!, NSAttributedString.Key.foregroundColor:  UIColor.mainColor() ])
            btn.setAttributedTitle(text1, for: .normal)
    //           btn.addTarget(self, action: #selector(gizlilikPolitikasi), for: .touchUpInside)
                   return btn
               }()

        let name : TweeAttributedTextField = {
                  let txt = TweeAttributedTextField()
                   txt.placeholder = "Name"
                  txt.font = UIFont(name: Utilities.fontBold, size: 14)!
                   txt.activeLineColor =   UIColor.mainColor()
                   txt.lineColor = .darkGray
                   txt.textAlignment = .center
                   txt.activeLineWidth = 1.5
                   txt.animationDuration = 0.7
                   txt.infoFontSize = 10
                   txt.infoTextColor = .red
                 txt.addTarget(self, action: #selector(formValidations), for: .editingChanged)
                   
                   return txt
               }()
    
    let email : TweeAttributedTextField = {
              let txt = TweeAttributedTextField()
               txt.placeholder = "E-Posta Adresinizi Giriniz"
              txt.font = UIFont(name: Utilities.fontBold, size: 14)!
               txt.activeLineColor =   UIColor.mainColor()
               txt.lineColor = .darkGray
               txt.textAlignment = .center
               txt.activeLineWidth = 1.5
               txt.animationDuration = 0.7
               txt.infoFontSize = 10
               txt.infoTextColor = .red
             txt.addTarget(self, action: #selector(formValidations), for: .editingChanged)
               
               return txt
           }()
 
    let password : TweeAttributedTextField = {
            let txt = TweeAttributedTextField()
                   txt.placeholder = "Şifre Belirleyin"
            txt.font = UIFont(name: Utilities.fontBold, size: 14)!
                   txt.activeLineColor =   UIColor.mainColor()
                   txt.lineColor = .darkGray
                   txt.textAlignment = .center
                   txt.activeLineWidth = 1.5
                   txt.animationDuration = 0.7
             txt.infoFontSize = 10
             txt.infoTextColor = .red
             txt.isSecureTextEntry = true
           txt.addTarget(self, action: #selector(formValidations), for: .editingChanged)
                   return txt
         }()
    let btnLogin : UIButton = {
              let btn = UIButton(type: .system)
                 btn.setTitle("Kaydol", for: .normal)
                btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 16)!
                 btn.backgroundColor = UIColor.mainColorTransparent()
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.darkGray, for: .disabled)
        btn.addTarget(self, action: #selector(signUp), for: .touchUpInside )
                 return btn
             }()
    let login : UIButton = {
             let btn = UIButton(type: .system)
             let text1 = NSMutableAttributedString(string: "You Have Already An Account! ", attributes :[NSAttributedString.Key.font : UIFont(name: Utilities.font, size: 14)!
                 , NSAttributedString.Key.foregroundColor: UIColor.lightGray ])
            text1.append(NSAttributedString(string: "Login", attributes :[NSAttributedString.Key.font : UIFont(name:Utilities.font, size: 14)!
                , NSAttributedString.Key.foregroundColor:UIColor.mainColor() ]))
                 btn.setAttributedTitle(text1, for: .normal)
             btn.addTarget(self, action: #selector(loginPage), for: .touchUpInside)
             return btn
         }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
          hideKeyboardWhenTappedAround()
          let stack = UIStackView(arrangedSubviews: [name,email,password,btnLogin])
          stack.distribution = .fillEqually
          stack.spacing = 16
          stack.axis = .vertical
          view.addSubview(stack)
          stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 40, marginLeft: 40, marginBottom: 0, marginRigth: 40, width: 0, heigth: 236)
          btnLogin.layer.cornerRadius = 50 / 2
        
          view.addSubview(login)
          login.anchor(top: nil, left: nil, bottom: view.bottomAnchor, rigth: nil, marginTop: 0, marginLeft: 0, marginBottom: 30, marginRigth: 0, width: 0, heigth: 40)
          login.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
         let stackViewTerms = UIStackView(arrangedSubviews: [labelContrackt,termsOfServiceBtn,lblAnd,privacyPolicy])
                    
                    stackViewTerms.alignment = .center
                    stackViewTerms.axis = .horizontal
                    stackViewTerms.spacing = 4
        
        let stackVi = UIStackView(arrangedSubviews: [stackViewTerms,lbl])
        

               stackVi.alignment = .center
               stackVi.axis = .vertical
               stackVi.spacing = 2
               stackVi.distribution = .fillEqually
               
               view.addSubview(stackVi)
        stackVi.anchor(top: nil, left: view.leftAnchor, bottom: login.topAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 12, marginBottom: 30, marginRigth: 12, width: 0, heigth: 0)
    }


 @objc func myTextFieldTextChanged(textField : TweeAttributedTextField){
      textField.text =  textField.text?.lowercased()
 }
 @objc func loginPage(){
     let v = Login()
     v.modalPresentationStyle = .fullScreen
     self.present(v, animated: true, completion: nil)
 }
 
 @objc func formValidations() {

     name.infoLabel.text = ""
     email.infoLabel.text = ""
     password.infoLabel.text = ""
     
     guard name.hasText , email.hasText, password.hasText else {
         btnLogin.isEnabled = false
         btnLogin.backgroundColor = UIColor.mainColorTransparent()
         return
     }
     
  
     guard name.hasText else {
     name.infoLabel.text = "Please Enter A Name"
          btnLogin.isEnabled = false
          btnLogin.backgroundColor = UIColor.mainColorTransparent()
         return
     }
     guard email.hasText else {
         email.infoLabel.text = "Please Enter An E-Mail Adress"
         btnLogin.isEnabled = false
         btnLogin.backgroundColor = UIColor.mainColorTransparent()
         return
     }
     
     
        guard
          password.hasText else {
             password.infoLabel.text = "Please Create A Password"
                btnLogin.isEnabled = false
                btnLogin.backgroundColor = UIColor.mainColorTransparent()
                return
        }
     guard password.text!.count > 5  else {
          password.infoLabel.text = "You Have Weak Password"
         btnLogin.isEnabled = false
         btnLogin.backgroundColor = UIColor.mainColorTransparent()
         return
     }
   
     self.btnLogin.isEnabled = true
     self.btnLogin.backgroundColor = UIColor.mainColor()
   
     
        
        
    }
 
 
 @objc func signUp(){
 
     let db = Firestore.firestore().collection("username")
           db.getDocuments { (querySnap, err) in
               if err == nil {
                   if !querySnap!.isEmpty{
                       for doc in querySnap!.documents {
                           if doc.documentID == self.email.text{
                               self.btnLogin.isEnabled = false
                               self.btnLogin.backgroundColor = UIColor.mainColor()
                           }
                           else
                           {
                               Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) { (result, err) in
                                 if err == nil {
//                                     let dic = ["email":self.email.text!,"name":self.name.text!,"username":"@"+self.userName.text!,"profileImage":"","uid":Auth.auth().currentUser!.uid,"github":"","insta":"","job":"","snap":"","twitter":"","age":self.ageCalgulate(),"skils":"#none"] as [String:Any]
//                                     let db = Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid)
//                                     db.setData(dic) { (err) in
//                                         if err == nil {
//                                             let db = Firestore.firestore().collection("username").document(self.userName.text!)
//                                             db.setData(["username":self.userName.text!,"uid":Auth.auth().currentUser!.uid]) { (err) in
//                                                 if err == nil {
//                                                     let vc = MainVC()
//                                                     vc.modalPresentationStyle = .fullScreen
//                                                     self.present(vc, animated: true, completion: nil)
//                                                 }
//                                             }
//
//                                         }
//                                     }
                                 }else{
                                     if err?.localizedDescription == "The email address is already in use by another account."{
                                         self.email.infoLabel.text = "The email address is already in use by another account." }
                                     return
                                                                     
                                                       }
                                                    }
                           }
                       }
                   }else{
                     Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) { (result, err) in
                      if err == nil {
//                          let dic = ["email":self.email.text!,"name":self.name.text!,"username":"@"+self.userName.text!,"profileImage":"","uid":Auth.auth().currentUser!.uid] as [String:Any]
//                          let db = Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid)
//                          db.setData(dic) { (err) in
//                              if err == nil {
//                                    let db = Firestore.firestore().collection("username").document(self.userName.text!)
//                                 db.setData(["username":self.userName.text!,"uid":Auth.auth().currentUser!.uid]) { (err) in
//                                     if err == nil {
//                                         let vc = MainVC()
//                                         vc.modalPresentationStyle = .fullScreen
//                                         self.present(vc, animated: true, completion: nil)
//                                                                                   }
//                                                                               }
//                              }
//                          }
                      }else{
                         if err?.localizedDescription == "The email address is already in use by another account."{
                          self.email.infoLabel.text = "The email address is already in use by another account." }
                          return
                                    
                      }
                   }
               }
           }
     
     }
 }
}
