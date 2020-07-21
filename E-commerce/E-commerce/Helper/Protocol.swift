//
//  Protocol.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

protocol HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption : MenuOption?)
}
protocol CartFooterDelegate{
    func odemeYap(for footer : CartFooter)
}
protocol CartCellDelegate{
    func removeItem(for cell : CartCell)
}
