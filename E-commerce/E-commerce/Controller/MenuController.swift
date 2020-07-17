//
//  MenuController.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit

private let cellId = "menuId"
class MenuController: UIViewController {

    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
    

    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mainColor()
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        
    }
 

}

extension MenuController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuOptionCell
        cell.backgroundColor = .mainColor()
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.name.text = menuOption!.description
        cell.typeImage.image = menuOption?.image
            return cell
        
    }
    
    
}
