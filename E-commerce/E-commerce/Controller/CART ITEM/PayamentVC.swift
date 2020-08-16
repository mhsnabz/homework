//
//  PayamentVC.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 21.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import CreditCardForm
import Stripe
import SVProgressHUD
class PayamentVC: UIViewController ,STPPaymentCardTextFieldDelegate, UITextFieldDelegate  {
    
    let paymentTextField = STPPaymentCardTextField()
    private var cardHolderNameTextField: TextField!
    private var cardParams: STPPaymentMethodCardParams!

    let odemeYap : UIButton = {
        let btn  = UIButton()
        btn.setTitle("Ödeme Yap", for: .disabled)
        btn.setBackgroundColor(color: .mainColorTransparent(), forState: .disabled)
        btn.titleLabel?.font = UIFont(name: Utilities.font, size: 14)
        btn.setTitleColor(.white, for: .disabled)
        
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
    
    lazy var creditCardView : CreditCardFormView = {
        let creditCardView = CreditCardFormView()
        creditCardView.cardHolderString = "Mazlum ABUL"
        creditCardView.cardGradientColors[Brands.Amex.rawValue] = [UIColor.red, UIColor.black]
        creditCardView.cardNumberFont = UIFont(name: "HelveticaNeue", size: 20)!
        creditCardView.cardPlaceholdersFont = UIFont(name: "HelveticaNeue", size: 10)!
        creditCardView.cardTextFont = UIFont(name: "HelveticaNeue", size: 12)!
        return creditCardView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        view.addSubview(creditCardView)
        creditCardView.anchor(top: headerBar.bottomAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 8, marginLeft: 8, marginBottom: 8, marginRigth: 8, width: 0, heigth: 190)
        
        paymentTextField.postalCodeEntryEnabled = false
        
        createTextField()
        cardParams = STPPaymentMethodCardParams()
        cardParams.number = "3434343434343434"
        cardParams.expMonth = 02
        cardParams.expYear = 17
        cardParams.cvc = "808"
        self.paymentTextField.cardParams = cardParams
        addDoneButtonOnKeyboard()
        
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Bitti", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        paymentTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        paymentTextField.resignFirstResponder()
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        creditCardView.cardHolderString = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cardHolderNameTextField {
            textField.resignFirstResponder()
            paymentTextField.becomeFirstResponder()
        } else if textField == paymentTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func createTextField() {
        
        cardHolderNameTextField = TextField(frame: CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44))
        cardHolderNameTextField.placeholder = "Kredi Kartı Üzerindeki Ad"
        cardHolderNameTextField.delegate = self
        cardHolderNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cardHolderNameTextField.setBottomBorder()
        cardHolderNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view.addSubview(cardHolderNameTextField)
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.delegate = self
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            cardHolderNameTextField.topAnchor.constraint(equalTo: creditCardView.bottomAnchor, constant: 20),
            cardHolderNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardHolderNameTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-25),
            cardHolderNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        view.addSubview(odemeYap)
        odemeYap.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, rigth: view.rightAnchor, marginTop: 20, marginLeft: 50, marginBottom: 20, marginRigth:50, width: 0, heigth: 40)
        odemeYap.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(headerBar)
        headerBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, rigth: view.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: 0, heigth: 60)
        dissmisButton.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
    }
    @objc func dissmis() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
        if textField.isValid {
            odemeYap.isHidden = false
            odemeYap.setTitleColor(.white, for: .normal)
            odemeYap.setBackgroundColor(color: .red, forState: .normal)
            odemeYap.setTitle("Ödeme Yap", for: .normal)
             odemeYap.titleLabel?.font = UIFont(name: Utilities.font, size: 14)
              odemeYap.layer.cornerRadius = 8
            
        }else{
            odemeYap.isHidden = true
         odemeYap.setTitle("Ödeme Yap", for: .disabled)
            odemeYap.setBackgroundColor(color: .mainColorTransparent(), forState: .disabled)
            odemeYap.titleLabel?.font = UIFont(name: Utilities.font, size: 14)
            odemeYap.setTitleColor(.white, for: .disabled)
            odemeYap.clipsToBounds = true
            odemeYap.layer.cornerRadius = 8
        }
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingCVC()
    }
}
extension  UITextField {
    
    func setBottomBorder() {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
