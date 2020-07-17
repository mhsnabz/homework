//
//  ContainerController.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    var menuController : UIViewController!
    var centrelController : UIViewController!
    var isExanded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureHomeContainerController()
        
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("added menu controller")
        }
    }
    
    func showMenuController(shouldExpand : Bool){
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centrelController.view.frame.origin.x = self.centrelController.view.frame.width - 80
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                         self.centrelController.view.frame.origin.x = 0
                     }, completion: nil)
        }
    }
    

}

extension ContainerController : HomeControllerDelegate {
    func handleMenuToggle() {
        if !isExanded{
             configureMenuController()
        }
        isExanded = !isExanded
        showMenuController(shouldExpand: isExanded)
    }
    
    
}
