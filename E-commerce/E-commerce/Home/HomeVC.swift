//
//  HomeVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import Lottie
class HomeVC: UIViewController {
    
    var delegate : HomeControllerDelegate?
    var isMenuOpen : Bool = false
    var menu = UIButton()
    var vc : ContainerController?
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = .white
        configureNavController()
        
    }

    func configureNavController(){

      
    
         
    
        

//        menu.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
//        menu.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        
        navigationController?.navigationBar.barTintColor = .mainColor()
        navigationController?.navigationBar.barStyle = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "E-Commarence Homework"
 
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
                 menuBtn.setImage(UIImage(named:"menu"), for: .normal)
                 menuBtn.addTarget(self, action: #selector(menuClick), for: .touchUpInside)
            let menuBarItem = UIBarButtonItem(customView: menuBtn)
            let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
            currHeight?.isActive = true
            self.navigationItem.leftBarButtonItem = menuBarItem
         
     
    }
    @objc func menuClick(){
        self.delegate?.handleMenuToggle(forMenuOption: nil)
        if !isMenuOpen {
            self.isMenuOpen = false
                         
           
        }else{
           
                self.isMenuOpen = true
          
          
        }
        
    }
}
