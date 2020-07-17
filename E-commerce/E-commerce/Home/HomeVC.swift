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
    var menu = AnimationView()
    var vc : ContainerController?
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = .white
        configureNavController()
        
    }

    func configureNavController(){

         menu.animation = Animation.named("menu")
          menu.clipsToBounds = false
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(menuClick)))
        menu.animationSpeed = 2

//        menu.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
//        menu.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        
        navigationController?.navigationBar.barTintColor = .mainColor()
        navigationController?.navigationBar.barStyle = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "E-Commarence Homework"
        let leftBarItem = UIBarButtonItem(customView: menu)
        
        navigationItem.setLeftBarButton(leftBarItem, animated: true)
    }
    @objc func menuClick(){
        self.delegate?.handleMenuToggle(forMenuOption: nil)
        if vc?.isExanded ?? false {
            menu.play(fromProgress: 90, toProgress: 0, loopMode: .none) { (a) in
                self.isMenuOpen = false
            }
            
        }else{
            menu.play(fromProgress: 0, toProgress: 90, loopMode: .none) { (a) in
                self.isMenuOpen = true
            }
        }
        
    }
}
