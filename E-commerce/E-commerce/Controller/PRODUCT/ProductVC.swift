//
//  ProductVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 19.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage
import FirebaseFirestore
private let shoesId = "ShoesId"
class ProductVC: UIViewController {
    var gender : String!
    var type : String!
    var typeModel : String!
    var list = [ProductList]()
    var size = [String]()
    var images = [String]()
    var isSelected = false
    
     let transparentView = UIView()
       let tableView = UITableView()
       var selectedButton = UIButton()
       var ordering = [String]()
    
    
    var titleText : String?{
        didSet{
            titleLbl.text = titleText
        }
    }
    
    var currentUser : CurrentUser!
     var collectionview: UICollectionView!
    var order : UIButton = {
         let btn = UIButton()
          btn.setTitle("Filtreleyin", for: .normal)
        btn.titleLabel?.font = UIFont(name: Utilities.font, size: 14)
        btn.backgroundColor = .mainColorTransparent()
          btn.addTarget(self, action: #selector(chooseOrder), for: .touchUpInside)
          btn.layer.cornerRadius = 8
        
          return btn
      }()
    let titleLbl : UILabel = {
        let lbl = UILabel()

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
        configureOrderingTB()
        configureCollectionView()
        
        getList()
    }
    
    //MARK: - functions
    
    func orderBySection(value : String!)  {
       
        if value ==  "En Pahalıdan En Ucuza"
        {
            self.list.sort { (post1, post2) -> Bool in
                return Int(post1.value!) > Int(post2.value!)
            }
            self.collectionview.reloadData()
        }else if value == "En Ucuzdan En Pahalıya"{
            
            self.list.sort { (post1, post2) -> Bool in
                return Int(post1.value!) < Int(post2.value!)
            }
            self.collectionview.reloadData()
        }
    }
    
    func  configureOrderingTB(){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(OrderingCell.self, forCellReuseIdentifier: "id")
        view.addSubview(order)
        order.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 8, marginLeft: 50, marginBottom: 0, marginRigth: 50, width: 0, heigth: 40)
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(headerBar)
        headerBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 60)
        dissmisButton.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
    }
    func configureCollectionView()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
              collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
              collectionview.dataSource = self
              collectionview.delegate = self
              collectionview.backgroundColor = .white
              collectionview.register(ShoesCell.self, forCellWithReuseIdentifier: shoesId)
              view.addSubview(collectionview)
              collectionview.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 60, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
    }
    private func getList(){
        let db = Firestore.firestore().collection(gender)
            .document(type).collection(typeModel)
        db.getDocuments { (querySnap, err) in
            if err == nil {
                if !querySnap!.isEmpty {
                     for doc in querySnap!.documents{
                        let model = ProductList.init(id : doc.documentID , dic: doc.data())
                        self.list.append(model)
                        self.collectionview.reloadData()
                    }
                }
               
            }
        }
    }
    
    
    //MARK: - handlers
    @objc func removeTransparentView(){
         let frame = selectedButton.frame
         UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
                             self.transparentView.alpha = 0
             self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.origin.x + 25, width: frame.width, height:0)
                         }, completion: nil)
     }
         func addTransparentView(frame : CGRect)  {
             let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                    transparentView.frame = window?.frame ?? self.view.frame
                    transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
             tableView.reloadData()
                    transparentView.alpha = 0
             self.view.addSubview(transparentView)
               tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 0)
                self.view.addSubview(tableView)
              tableView.layer.cornerRadius = 5
             let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
                 transparentView.addGestureRecognizer(tapgesture)
               UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
                       self.transparentView.alpha = 0.5
                 self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.origin.x , width: frame.width, height: CGFloat(self.ordering.count * 50))
                   }, completion: nil)
          }
    
    @objc func chooseOrder(){
        ordering = ["En Pahalıdan En Ucuza","En Ucuzdan En Pahalıya"]
        selectedButton = order
        addTransparentView(frame: order.frame)
    }
    @objc func dissmis() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
extension ProductVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shoesId, for: indexPath) as! ShoesCell
        
        cell.img.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
       cell.img.sd_setImage(with: URL(string: list[indexPath.row].thumbImage!) , completed: nil)
        cell.name.text = list[indexPath.row].name
        cell.value.text = list[indexPath.row].value!.description + " ₺"
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 2) + 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SingleProduct()
        vc.productName = list[indexPath.row].name
        vc.item = list[indexPath.row]
        vc.number = list[indexPath.row].number ?? []
        vc.image = list[indexPath.row].image ?? []
        vc.currentUser = currentUser
        vc.gender = gender
        vc.type = type
        vc.typeModel = typeModel
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
extension ProductVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordering.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! OrderingCell
        cell.textLabel?.text = ordering[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           order.setTitle(ordering[indexPath.row], for: .normal)
             order.backgroundColor = .mainColor()
        isSelected = true
        orderBySection(value: ordering[indexPath.row])
        self.removeTransparentView()
    }
    
    
}
