//
//  CartVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import FirebaseFirestore
private let cellID = "id"
private let footerID = "footerID"
import SVProgressHUD
class CartVC: UIViewController {
    var currentUser : CurrentUser!{
        didSet{
        }
    }
    var total : Double! = 0.0
    var list = [AddToCart]()
    var totalPrice : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Utilities.fontBold, size: 18)
        lbl.textColor = .systemGreen
        return lbl
    }()
    var collectionview: UICollectionView!
    let titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Alışverişi Tamamla"
        lbl.font = UIFont(name: Utilities.font, size: 15)
        lbl.textColor = .white
        return lbl
    }()
    let dissmisButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        
        return btn
    }()
    lazy var headerBar : UIView = {
        let v = UIView()
        v.backgroundColor = .menuColor()
        v.addSubview(dissmisButton)
        dissmisButton.anchor(top: nil, left: v.leftAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 20, marginBottom: 0, marginRigth: 0, width: 20, heigth: 20)
        dissmisButton.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        v.addSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        titleLbl.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.addSubview(totalPrice)
        totalPrice.anchor(top: headerBar.bottomAnchor, left: nil, bottom: nil, rigth: nil, marginTop: 8, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        totalPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        configureCollectionView()
        getCartList()
        
    }
    func configureCollectionView()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = .white
        collectionview.register(CartCell.self, forCellWithReuseIdentifier: cellID)
        collectionview.register(CartFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        view.addSubview(collectionview)
        collectionview.anchor(top: totalPrice.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 10, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
    }
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(headerBar)
        headerBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 60)
        dissmisButton.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
    }
    @objc func dissmis(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getCartList(){
        let db = Firestore.firestore().collection("user")
            .document(currentUser.uid!).collection("cart")
        db.addSnapshotListener { (querySnap, err) in
            if err == nil{
                if !querySnap!.isEmpty{
                    for doc in querySnap!.documentChanges{
                        if doc.type == .added{
                            
                            self.list.append(AddToCart.init(id: doc.document.documentID, dic: doc.document.data()))
                            self.collectionview.reloadData()
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    
}
extension CartVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CartCell
        cell.delegate = self
        cell.img.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        cell.img.sd_setImage(with: URL(string: list[indexPath.row].thumbImage!), completed: nil)
        cell.price.text = list[indexPath.row].value.description + " ₺"
        
        
        cell.list = list[indexPath.row]
        total += list[indexPath.row].value.rounded(toPlaces: 2)
        self.totalPrice.text = "Toplam: " + self.total.description + " ₺"
        if list[indexPath.row].gender == "man"{
            cell.gender.text = "Erkek"
        }
        if list[indexPath.row].gender == "woman"{
            cell.gender.text = "Kadın"
        }
        if list[indexPath.row].type == "shoes" {
            cell.itemType.text = "Ayakkabı"
        }
        if list[indexPath.row].productType == "spor" {
            cell.type.text = "Spor"
        }
        cell.itemName.text = list[indexPath.row].name!
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID , for: indexPath) as! CartFooter
            footerView.delegate = self
            
            if list.isEmpty{
                footerView.btn.setTitle("Sepetiniz Boş", for: .normal)
                footerView.btn.setBackgroundColor(color: .mainColorTransparent(), forState: .normal)
            }else{
                footerView.btn.setTitle("Ödeme Yap", for: .normal)
            }
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}
extension CartVC : CartFooterDelegate{
    func odemeYap(for footer: CartFooter) {
        let vc = PayamentVC()
        vc.total = self.total
        vc.list = list
        vc.currentUser = currentUser
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
extension CartVC : CartCellDelegate {
    func removeItem(for cell: CartCell) {
        SVProgressHUD.setBackgroundColor(.mainColor())
        SVProgressHUD.setFont(UIFont(name: Utilities.font, size: 12)!)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Siliniyor")
        guard let gender = cell.list?.gender else { return }
        guard let type = cell.list?.type else { return }
        guard let name = cell.list?.name else { return }
        guard let size = cell.list?.number else { return }
        
        let ref = Firestore.firestore().collection(gender)
            .document(type).collection(type).document(name)
        
        ref.updateData(["number" : FieldValue.arrayUnion([Double(size)])]) { (err) in
            if err != nil {
                print("err \(err.debugDescription)!")
            }else{
                let ref_delete = Firestore.firestore().collection("user")
                    .document(self.currentUser!.uid!).collection("cart").document(name)
                ref_delete.delete { (err) in
                    if err == nil {
                        SVProgressHUD.showSuccess(withStatus: "Silindi")
                        self.dissmis()
                        
                    }
                }
            }
        }
  
       
    }
}
