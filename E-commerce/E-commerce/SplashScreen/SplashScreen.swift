//
//  SplashScreen.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import RevealingSplashView
class SplashScreen: UIViewController {
   let splahScreen  = RevealingSplashView(iconImage: UIImage(named: "logo")!, iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: .white)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
               navigationController?.navigationBar.isHidden = true
                view.addSubview(splahScreen)
               splahScreen.animationType = .twitter
        splahScreen.startAnimation() {
            let vc = ContainerController()
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
