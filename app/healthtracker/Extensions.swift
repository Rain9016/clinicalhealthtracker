//
//  Extensions.swift
//  sendLocation
//
//  Created by untitled on 19/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

extension UIImage {
    /*******************************/
    /* TURN A STRING INTO AN IMAGE */
    /*******************************/
    
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

extension UIViewController {    
    /*****************************/
    /* SEND AN ALERT TO THE USER */
    /*****************************/
    //http://stackoverflow.com/questions/28152526/how-do-i-open-phone-settings-when-a-button-is-clicked-ios
    
    func sendAlert(title: String, message: String) {
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

