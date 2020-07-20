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

    var item : ProductList!{
        didSet{
            self.itemName.text = item.name
            self.value.text = item.value!.description + " ₺"
            self.stockLbl.text = "Tükenmek Üzere Son " + (item.number?.count.description)! + " ürün"
        }
    }
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
    
   let itemName : UILabel = {
           let lbl = UILabel()
           lbl.font = UIFont(name: Utilities.font, size: 14)
           lbl.textColor = .darkGray
           return lbl
       }()
       let value : UILabel = {
           let lbl = UILabel()
                  lbl.font = UIFont(name: Utilities.font, size: 14)
                  lbl.textColor = .mainColor()
                  return lbl
       }()
    
    var sizeChoose : UIButton = {
        let btn = UIButton()
        btn.setTitle("Beden Seçin", for: .normal)
        btn.clipsToBounds = true
        btn.titleLabel?.font = UIFont(name: Utilities.font, size: 12)
        btn.layer.cornerRadius = 4
        btn.setBackgroundColor(color: .mainColorTransparent(), forState: .normal)
        return btn
    }()
    let stockLbl : UILabel = {
        let lbl = UILabel ()
        lbl.textColor = .red
        lbl.font = UIFont(name: Utilities.font, size: 12)
        return lbl
    }()
    var addToCart : UIButton = {
          let btn = UIButton()
          btn.setTitle("Sepete Ekle", for: .normal)
          btn.clipsToBounds = true
          btn.titleLabel?.font = UIFont(name: Utilities.fontBold, size: 14)
          btn.layer.cornerRadius = 4
          btn.setBackgroundColor(color: .red, forState: .normal)
          return btn
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
//        }

        view.addSubview(itemName)
       view.addSubview(value)
      itemName.anchor(top: collectionview.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: nil, marginTop: 8, marginLeft: 8, marginBottom: 8, marginRigth: 8, width: 0, heigth: 0)
        value.anchor(top: collectionview.bottomAnchor, left: nil, bottom: nil, rigth: view.rightAnchor, marginTop: 8, marginLeft: 8, marginBottom: 8, marginRigth: 8, width: 0, heigth: 0)
        view.addSubview(stockLbl)
        stockLbl.anchor(top: itemName.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: nil, marginTop: 8, marginLeft: 8, marginBottom: 0, marginRigth: 0, width: 0, heigth: 0)
        view.addSubview(sizeChoose)
        sizeChoose.anchor(top: stockLbl.bottomAnchor, left: nil, bottom: nil, rigth: nil, marginTop: 12, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 200, heigth: 35)
        sizeChoose.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(addToCart)
        addToCart.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 30, marginBottom: 20, marginRigth: 30, width: 0, heigth: 40)

        
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
    
    var imageStartingFrame : CGRect?
       var blackBackGround : UIView?
       func performImageZoomLogic(image : UIImageView){
           
           let startingFrame = CGRect(x: 0, y: 70, width: self.collectionview.bounds.width, height: self.collectionview.bounds.height)
           self.imageStartingFrame = startingFrame
        let zoomingImageView = UIImageView(frame: startingFrame)
           zoomingImageView.backgroundColor = .black
           zoomingImageView.image = image.image
           zoomingImageView.contentMode = .scaleAspectFit
           zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissImage)))
           zoomingImageView.isUserInteractionEnabled = true
           
           if let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
               blackBackGround = UIView(frame: keyWindow.frame)
               blackBackGround?.backgroundColor = .black
               blackBackGround?.alpha = 0
               keyWindow.addSubview(blackBackGround!)
               keyWindow.addSubview(zoomingImageView)
               UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                   self.blackBackGround?.alpha = 1
                   self.inputAccessoryView?.alpha = 0
                let h1 = startingFrame.height / startingFrame.width * keyWindow.frame.width
                   zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: h1)
                   zoomingImageView.center = keyWindow.center
               }, completion: nil)
               
           }
           
           
           
           
       }
    
    @objc func dismissImage(tabGesture : UITapGestureRecognizer){
        
        
        
        if  let zoomOutImageView = tabGesture.view {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.imageStartingFrame!
                self.blackBackGround?.alpha = 0
                self.inputAccessoryView?.alpha = 1
            }) { (bool) in
                zoomOutImageView.removeFromSuperview()
            }
            
            
        }
        
    }
    
    func configureCollectionView()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
    
              collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
              collectionview.dataSource = self
              collectionview.delegate = self
              collectionview.backgroundColor = .white
           
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
        cell.img.frame = CGRect(x: 0, y: 0,width: collectionView.bounds.width, height: collectionView.bounds.height )
        cell.img.sd_setImage(with: URL(string: image![indexPath.row]), placeholderImage: UIImage(named: "logo"), completed: nil)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: image![indexPath.row]), completed: nil)
        performImageZoomLogic(image: imageView)
    }
    
    
}
