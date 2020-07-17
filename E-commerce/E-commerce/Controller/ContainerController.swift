//
//  ContainerController.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    var menuController : MenuController!
    var centrelController : UIViewController!
   public var isExanded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureHomeContainerController()
        
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    override var prefersStatusBarHidden: Bool{
        return isExanded
    }

    func configureHomeContainerController(){
        let homeController = HomeVC()
        homeController.delegate = self
        centrelController = UINavigationController(rootViewController: homeController)
        view.addSubview(centrelController.view)
        addChild(centrelController)
        centrelController.didMove(toParent: self)
    }
    func configureMenuController()  {
        if menuController == nil {
            self.menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("added menu controller")
        }
    }
    
    func showMenuController(shouldExpand : Bool ,  menuOption  : MenuOption?){
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centrelController.view.frame.origin.x = self.centrelController.view.frame.width - 80
            }, completion: nil)
        }else{
             UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                            self.centrelController.view.frame.origin.x = 0
                   }) { (_) in
                       guard let menuOption = menuOption else{return}
                       self.didSelectMenuOption(menuOPtion: menuOption)
                   }
         
        }
          animateStatusBar()
    }
    func animateStatusBar(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    func didSelectMenuOption (menuOPtion : MenuOption){
        switch menuOPtion {
        case .man:
            print("man")
        case .woman:
            print("woman")
        case .kid:
            print("kid")
        }
       
    }

}

extension ContainerController : HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
            if !isExanded{
                 configureMenuController()
            }
            isExanded = !isExanded
        showMenuController(shouldExpand: isExanded, menuOption: menuOption)
    }
    
    
    
}
               

