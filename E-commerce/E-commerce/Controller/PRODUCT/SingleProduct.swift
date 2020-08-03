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
import FirebaseAuth
import FirebaseFirestore
class SingleProduct: UIViewController {
    
    var isSelected = false
    var gender : String!
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var numbers = [Int]()
    var type : String!
    var typeModel : String!
    var item : ProductList!{
        didSet{
            self.itemName.text = item.name
            self.value.text = item.value!.description + " ₺"
            if item.number != nil{
                self.stockLbl.text = "Tükenmek Üzere Son " + (item.number?.count.description)! + " ürün"
            }else{
                self.stockLbl.text = "Stokta Yok"
            }
            
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
            number?.sort(by: { (i, i2) -> Bool in
                return i < i2
            })
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
        btn.addTarget(self, action: #selector(chooseOrder), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(addToCartFunc), for: .touchUpInside)
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
        
        configureOrderingTB()
        view.addSubview(addToCart)
        addToCart.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 30, marginBottom: 20, marginRigth: 30, width: 0, heigth: 40)
        
        
        
    }
    @objc func addToCartFunc()
    {
        if isSelected{
            addToCart.isEnabled = true
            
            let dic = ["name": item.name!,
                       "number":Double(selectedButton.titleLabel!.text!)!,
                       "value":Double(self.item.value!),
                       "productType":typeModel!,
                       "type":type!,"gender":gender!,"thumbImage":item.thumbImage!] as [String:Any]
            
            
            let db = Firestore.firestore().collection("user")
                .document(currentUser!.uid!).collection("cart").document(self.item!.id!)
            db.setData(dic, merge: true) { (err) in
                if err == nil {
                    let db = Firestore.firestore().collection(self.gender!)
                        .document(self.type!).collection(self.typeModel).document(self.item.id!)
                    db.updateData([
                        "number": FieldValue.arrayRemove([Double(self.selectedButton.titleLabel!.text!)!])
                    ]) { (err) in
                        if err != nil {
                            print("err \(err?.localizedDescription as Any)")
                        }
                    }
                    
                }
            }
            
        }else{
            addToCart.isEnabled = false
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
    func  configureOrderingTB(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderingCell.self, forCellReuseIdentifier: "id")
        view.addSubview(sizeChoose)
        sizeChoose.anchor(top: stockLbl.bottomAnchor, left: nil, bottom: nil, rigth: nil, marginTop: 12, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 200, heigth: 35)
        sizeChoose.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    //MARK: - handlers
    @objc func removeTransparentView(){
        let frame = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.origin.x , width: frame.width, height:0)
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
        tableView.rowHeight = 40
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y  + 40 , width: frame.width, height: 90)
        }, completion: nil)
    }
    
    @objc func chooseOrder(){
        numbers = number!
        selectedButton = sizeChoose
        addTransparentView(frame: sizeChoose.frame)
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
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: URL(string: image![indexPath.row]), completed: nil)
        performImageZoomLogic(image: imageView)
    }
    
    
}
extension SingleProduct : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! OrderingCell
        cell.textLabel?.text = numbers[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sizeChoose.setTitle(numbers[indexPath.row].description, for: .normal)
        sizeChoose.backgroundColor = .mainColor()
        isSelected = true
        //        orderBySection(value: ordering[indexPath.row])
        self.removeTransparentView()
    }
    
    
}
