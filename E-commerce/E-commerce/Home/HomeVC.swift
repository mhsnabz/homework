//
//  HomeVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import Lottie
import FirebaseFirestore
import FirebaseAuth
private let cellId  = "cellId"
class HomeVC: UIViewController {
    
    var currentUser : CurrentUser!{
        didSet{
            getCartItems()
        }
    }
    var delegate : HomeControllerDelegate?
    var isMenuOpen : Bool = false
    var menu = UIButton()
    var vc : ContainerController?
    var itemList = [AddToCart]()
    
    
    var collectionview: UICollectionView!
      var carAnimaiton = AnimationView()
    
  
    let badgeBtn : UIButton = {
       let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.setBackgroundColor(color: .red, forState: .normal)
        btn.setTitle("1", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 10)
        return btn
    }()
     var anim = AnimationView()
    lazy var cart : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize (width: 0, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.3
       let tap = UITapGestureRecognizer(target: self, action: #selector(handleTab))
       view.addGestureRecognizer(tap)
        anim = .init(name: "car")
        anim.animationSpeed = 1
        anim.loopMode = .loop
        anim.play()
        view.addSubview(anim)
        anim.anchor(top: nil, left: nil, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 40, heigth: 40)
        anim.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        anim.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    let cartButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize (width: 25, height: 25)
        btn.layer.shadowRadius = 25
        btn.layer.shadowOpacity = 0.6
    
        return btn
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
//        getCartItems()
        carAnimaiton.play()
        anim.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        carAnimaiton.stop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = .white
       setNavigationBar()
        
        configureCollectionView()
        
        view.addSubview(cart)
        cart.anchor(top: nil, left: nil, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 20, marginRigth: 20, width: 60, heigth: 60)
        cart.layer.cornerRadius = 30
        
        view.addSubview(badgeBtn)
        badgeBtn.anchor(top: cart.topAnchor, left: nil, bottom: nil, rigth: cart.rightAnchor, marginTop: -8, marginLeft: 0, marginBottom: 0, marginRigth: 8, width: 20, heigth: 20)
        
    }

    
    func getCartItems(){
        let db = Firestore.firestore().collection("user")
            .document(currentUser.uid!).collection("cart")
        db.addSnapshotListener { (querySnap, err) in
            if err == nil {
                if !querySnap!.isEmpty {
                    self.badgeBtn.setTitle(querySnap?.documents.count.description, for: .normal)
                    for doc in querySnap!.documents{
                        self.itemList.append(AddToCart.init(id: doc.documentID, dic: doc.data()))
                        
                    }
                }else{
                    self.badgeBtn.isHidden = true
                }
                
            }
        }
    }
    //MARK: -functions
    @objc func handleTab(){

        let vc = CartVC()
        vc.currentUser = currentUser
        
        self.present(vc, animated: true, completion: nil)
            
    }
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
              collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
              collectionview.dataSource = self
              collectionview.delegate = self
        collectionview.backgroundColor = .white
        collectionview.register(HomeVcCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionview)
        collectionview.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
    }
        func setNavigationBar()  {
      
            
            carAnimaiton = .init(name: "car")
                   carAnimaiton.animationSpeed = 1
                   carAnimaiton.loopMode = .loop
            carAnimaiton.play()
                         NSLayoutConstraint.activate([
                             carAnimaiton.heightAnchor.constraint(equalToConstant: 50),
                             carAnimaiton.widthAnchor.constraint(equalToConstant: 50)
                         ])
               
               navigationItem.titleView = carAnimaiton
           
            let menuBtn = UIButton(type: .custom)
              menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
                       menuBtn.setImage(UIImage(named:"menu"), for: .normal)
                       menuBtn.addTarget(self, action: #selector(menuClick), for: .touchUpInside)
                  let menuBarItem = UIBarButtonItem(customView: menuBtn)
                  let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
                  currWidth?.isActive = true
                  let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
                  currHeight?.isActive = true
                  self.navigationItem.leftBarButtonItem = menuBarItem
    }

    @objc func menuClick(){
        self.delegate?.handleMenuToggle(forMenuOption: nil)
        if !isMenuOpen {
            self.isMenuOpen = false
                         
           
        }else{
           
                self.isMenuOpen = true
          
          
        }
        
    }
}
extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeVcCell
        cell.backgroundColor = .white
//
     
        cell.img.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 130)
        let menuOption = CollectionViewOption(rawValue: indexPath.row)
        cell.img.image = menuOption?.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: 130 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
}
