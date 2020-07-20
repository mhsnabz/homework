//
//  ContainerController.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import FirebaseAuth
class ContainerController: UIViewController {

    var menuController : MenuController!
    var centrelController : UIViewController!
    var currentUser : CurrentUser!{
        didSet{
            let vc = HomeVC()
            vc.currentUser = currentUser
        }
    }
    
   public var isExanded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureHomeContainerController()
        
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
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
          
    }
    func animateStatusBar(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    func didSelectMenuOption (menuOPtion : MenuOption){
        switch menuOPtion {
        case .man:
         let vc = ManVC()
         vc.currentUser = currentUser
         vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        case .woman:
              let vc = WomanVC()
                 vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
        case .kid:
               let vc = KidVC()
                 vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
        case .profile:
                let vc = ProfileVC()
                vc.currentUser = currentUser
                present(vc, animated: true, completion: nil)
        case .logOut:
            do {
                      try Auth.auth().signOut()
                      let vc = SplashScreen()
                      vc.modalPresentationStyle = .fullScreen //or .overFullScreen for
                      self.present(vc, animated: true, completion: nil)
                  }
                  catch{
                      print(error.localizedDescription)
                  }
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
               

