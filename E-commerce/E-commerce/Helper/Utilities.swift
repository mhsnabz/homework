//
//  Utilities.swift
//  E-commerce
//
//  Created by mahsun abuzeyitoğlu on 17.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import SVProgressHUD
class Utilities  {
    
    
    
    static var font =  "AvenirNext-Medium"
    static var fontBold =  "AvenirNext-DemiBold"
    static var italic = "AvenirNext-Italic"
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.mainColor()
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    static func enabledButton (_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.mainColorTransparent()
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    public static func showProgress(msg : String?){
        SVProgressHUD.setBackgroundColor(.mainColor())
        SVProgressHUD.show(withStatus: msg)
    }
    public  static func dismissProgres(time : TimeInterval){
        SVProgressHUD.dismiss(withDelay: time)
    }
    
}
extension UIView{
    func anchor(top : NSLayoutYAxisAnchor?
        ,left : NSLayoutXAxisAnchor?,
         bottom : NSLayoutYAxisAnchor? ,
         rigth: NSLayoutXAxisAnchor?,
         marginTop : CGFloat ,
         marginLeft : CGFloat ,
         marginBottom: CGFloat
        ,marginRigth : CGFloat ,
         width : CGFloat ,
         heigth : CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: marginTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: marginLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -marginBottom).isActive = true
        }
        if let rigth = rigth {
            self.rightAnchor.constraint(equalTo: rigth, constant: -marginRigth).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if heigth != 0{
            heightAnchor.constraint(equalToConstant: heigth).isActive = true
        }
    }
    
}
extension UIColor {
    static func mainColor() -> UIColor {
        return  UIColor.init(red: 55/255, green: 99/255, blue: 239/255, alpha: 1)
    }
    static func dolorColor() -> UIColor {
        return  UIColor.init(red: 133, green: 187, blue: 101, alpha: 1)
    }
    static func mainColorTransparent() -> UIColor {
        return  UIColor.init(red: 55/255, green: 99/255, blue: 239/255, alpha: 0.4)
    }
    static func menuColor() -> UIColor {
        return  UIColor.init(red: 92/255, green: 121/255, blue: 233/255, alpha: 1)
    }
    static func linkColor() -> UIColor {
        return  UIColor.init(red: 70/255, green: 140/255, blue: 247/255, alpha: 1)
    }
    
}
extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return " şimdi "
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) dk önce"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) saat önce"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) gün önce"
        }
        
        return "\(secondsAgo / week) hafta önce"
    }
}
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
var vSpinner : UIView?




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension Double {
    
    
    // returns the date formatted.
    var dateFormatted : String? {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        return dateFormatter.string(from: date)
    }
    
    // returns the date formatted according to the format string provided.
    func dateFormatted(withFormat format : String) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
