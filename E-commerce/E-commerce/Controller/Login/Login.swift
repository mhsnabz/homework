//
//  Login.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import RevealingSplashView
import TweeTextField
import Firebase
import JDropDownAlert
import SVProgressHUD
import PopupDialog

class Login: UIViewController {
let progres = SVProgressHUD.self
    let logoView : UIImageView = {
          let image = UIImageView()
           image.image = UIImage(named: "logo")
           image.contentMode = .scaleAspectFit
           return image
       }()
       
       
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
       
        let forgetPassWrodBtn : UIButton = {
            let btn = UIButton(type: .system)
            let text1 = NSMutableAttributedString(string: "Şifremi Unuttum ! ", attributes :[NSAttributedString.Key.font : UIFont(name: Utilities.font, size: 14)!
                , NSAttributedString.Key.foregroundColor: UIColor.lightGray ])
           text1.append(NSAttributedString(string: "Şifreni Sıfırla", attributes :[NSAttributedString.Key.font : UIFont(name:Utilities.font, size: 14)!
               , NSAttributedString.Key.foregroundColor:UIColor.mainColor() ]))
                btn.setAttributedTitle(text1, for: .normal)
//            btn.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
            return btn
        }()
       let email : TweeAttributedTextField = {
           let txt = TweeAttributedTextField()
         
             txt.placeholder = "E-posta Adresi"
            txt.font = UIFont(name: Utilities.font, size: 14)!
             txt.activeLineColor =   UIColor.mainColor()
             txt.lineColor = .darkGray
             txt.textAlignment = .center
             txt.activeLineWidth = 1.5
             txt.animationDuration = 0.7
             txt.infoFontSize = UIFont.smallSystemFontSize
                      txt.infoTextColor = .red
                     txt.infoAnimationDuration = 0.4
            txt.keyboardType = UIKeyboardType.emailAddress
            txt.addTarget(self, action: #selector(formValidations), for: .editingChanged)
            
            return txt
        }()
        
        
        let password : TweeAttributedTextField = {
           let txt = TweeAttributedTextField()
                  txt.placeholder = "Şifreniz"
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
               btn.setTitle("Giris", for: .normal)
           btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 16)!
              btn.addTarget(self, action: #selector(loginPage), for: .touchUpInside)
               btn.backgroundColor = UIColor.mainColorTransparent()
               return btn
           }()
     
       let btnReg : UIButton = {
                let btn = UIButton(type: .system)
                btn.setTitle("Kaydol", for: .normal)
                btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 16)!
               btn.addTarget(self, action: #selector(SignUpPage), for: .touchUpInside)

                      return btn
            }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         navigationController?.navigationBar.isHidden = true
         view.addSubview(logoView)
         hideKeyboardWhenTappedAround()

         logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         logoView.anchor(top: view.topAnchor, left: nil, bottom: nil, rigth: nil, marginTop: 40, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 100, heigth: 100)
                     
                let stackViewLogin = UIStackView(arrangedSubviews: [email,password,btnLogin])
                stackViewLogin.distribution = .fillEqually
                stackViewLogin.spacing = 14
                stackViewLogin.axis = .vertical
                     Utilities.styleTextField(email)
                     Utilities.styleTextField(password)
                     Utilities.enabledButton(btnLogin)
                view.addSubview(stackViewLogin)
         stackViewLogin.anchor(top: logoView.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 10, marginLeft: 40, marginBottom: 0, marginRigth: 40, width: 0, heigth: 178)
         
         view.addSubview(btnReg)
         btnReg.anchor(top: stackViewLogin.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 14, marginLeft: 40, marginBottom: 0, marginRigth: 40, width: 0, heigth: 50)
         Utilities.styleHollowButton(btnReg)
           view.addSubview(forgetPassWrodBtn)
               forgetPassWrodBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 16, marginBottom: 32, marginRigth: 16, width: 0, heigth: 0)
        let stackViewTerms = UIStackView(arrangedSubviews: [labelContrackt,termsOfServiceBtn,lblAnd,privacyPolicy])
                   
                   stackViewTerms.alignment = .center
                   stackViewTerms.axis = .horizontal
                   stackViewTerms.spacing = 4
                let stack = UIStackView(arrangedSubviews: [stackViewTerms,lbl])
              stack.alignment = .center
              stack.axis = .vertical
              stack.spacing = 2
              stack.distribution = .fillEqually
              
              view.addSubview(stack)
              stack.anchor(top: nil, left: view.leftAnchor, bottom: forgetPassWrodBtn.topAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 12, marginBottom: 30, marginRigth: 12, width: 0, heigth: 0)
    }
    
        @objc func formValidations() {
           guard
               email.hasText , password.hasText else {
                   btnLogin.isEnabled = false
                   btnLogin.backgroundColor = UIColor.mainColorTransparent()
                   return
           }
           btnLogin.isEnabled = true
           btnLogin.backgroundColor = UIColor.mainColor()
           
       }
    @objc func SignUpPage (){
        let nextVC = Register()
           nextVC.modalPresentationStyle =  .fullScreen
            self.present(nextVC, animated: true, completion: nil)
            
      }

    @objc func loginPage(){
        
//         self.progres.setBackgroundColor(.mainColor())
//         self.progres.setForegroundColor(.white)
//        self.progres.show(withStatus: "Lütfen Bekleyin")

        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (result, err) in
            if err != nil {
                if err?.localizedDescription == "The password is invalid or the user does not have a password." {
                          
                   
                                  self.password.infoLabel.text = "Şifren Hatalı"
                                self.email.infoLabel.text = ""

                               return
                           }
                           if err?.localizedDescription == "The email address is badly formatted."{
                                self.password.infoLabel.text = ""
                                       self.email.infoLabel.text = "E-Posta Adresin Hatalı"
      
                            
                               return
                           }
                           if err?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted."{
                                self.password.infoLabel.text = ""
                                       self.email.infoLabel.text = "E-Posta Adresinde Kayıtlı Kullanıcı Yok"
                     
                           
                               return
                           }
                           if err?.localizedDescription == "Network error (such as timeout, interrupted connection or unreachable host) has occurred."{

                               self.password.infoLabel.text = ""
                               self.email.infoLabel.text = "Internet Bağlantınızı Kontrol Ediniz"
                               self.password.infoLabel.text = ""
                               self.email.infoLabel.text = "Internet Bağlantınızı Kontrol Ediniz"
                            
                        
                               return
                           }
            }
            else{
                let db = Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid)
                         db.getDocument { (docSnap, err) in
                             if err == nil {
                                 let nextVC = HomeVC()
                                 
//                                 nextVC.user = currentUser.init(uid: Auth.auth().currentUser!.uid, dic: docSnap!.data()!)
                                 nextVC.modalPresentationStyle =  .fullScreen
                                 self.present(nextVC, animated: true, completion: nil)
                             }else{
                                 print(err?.localizedDescription as Any)
                             }
                         }
               
            }
        }
        
        
    
    }
  
}
