//
//  SingleProduct.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 20.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
private let cellId = "as"
import SDWebImage
class SingleProduct: UIViewController {

    var productName : String!{
        didSet{
            titleLbl.text = productName
        }
    }
    var image : [String]?{
        didSet{
            print("image : \(image!.count) "  )
        }
    }
    var number : [Int]?{
        didSet{
            print("number : \( number!.count) " )
        }
    }
    
    var collectionview: UICollectionView!
    var timer = Timer()
    var counter = 0
    var currentUser : CurrentUser!
    let titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "ERKEK"
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
        configureCollectionView()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
       

        
    }
    @objc func changeImage()
    {
        if counter < image!.count {
            let index = IndexPath.init(item: counter, section: 0 )
            self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0 )
            self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }
    }
    func configureCollectionView()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
    
              collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
              collectionview.dataSource = self
              collectionview.delegate = self
              collectionview.backgroundColor = .white
              collectionview.isPagingEnabled = true
              collectionview.register(SingleProductCell.self, forCellWithReuseIdentifier: cellId)
              view.addSubview(collectionview)
              collectionview.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 10, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: view.frame.width, heigth: view.frame.height / 2)
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
  

}
extension SingleProduct : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SingleProductCell
        cell.img.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
        cell.img.sd_setImage(with: URL(string: image![indexPath.row]), placeholderImage: UIImage(named: "logo"), completed: nil)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    
}
