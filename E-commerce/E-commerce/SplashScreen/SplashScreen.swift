//
//  SplashScreen.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import RevealingSplashView
import FirebaseAuth
import FirebaseFirestore
class SplashScreen: UIViewController {
    let splahScreen  = RevealingSplashView(iconImage: UIImage(named: "logo")!, iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: .white)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(splahScreen)
        splahScreen.animationType = .twitter
        splahScreen.startAnimation() {
            
            
            if Auth.auth().currentUser?.uid != nil {
                let db = Firestore.firestore().collection("user")
                    .document(Auth.auth().currentUser!.uid)
                db.getDocument { (docSnap, err) in
                    if err == nil {
                        let user = CurrentUser.init(dic: docSnap!.data()!)
                        let vc = ContainerController()
                        vc.currentUser = user
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        let vc = Login()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                        return }}
                
            }else{
                let vc = Login()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } } }
    
    
    
    
}
