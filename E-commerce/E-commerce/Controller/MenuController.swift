//
//  MenuController.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import Lottie
private let cellId = "menuId"
class MenuController: UIViewController {

    var tableView : UITableView!
    var carAnimaiton = AnimationView()
    var delegate : HomeControllerDelegate?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        carAnimaiton = .init(name: "car")
        carAnimaiton.animationSpeed = 1
        carAnimaiton.loopMode = .loop
      
        
        view.addSubview(carAnimaiton)
        carAnimaiton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft:0, marginBottom: 0, marginRigth: 0, width: 150, heigth: 150)
       
        
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          carAnimaiton.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
          carAnimaiton.stop()
    }
    
    func configureTableView(){
        
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorColor = .mainColorTransparent()

        tableView.rowHeight = 80
        view.addSubview(tableView)
        tableView.anchor(top: carAnimaiton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 20, marginRigth: 0, width: 0, heigth: 0)
        
    }
 

}

extension MenuController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuOptionCell
        cell.backgroundColor = .white
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.name.text = menuOption!.description
        cell.typeImage.image = menuOption?.image
            return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
    
}
