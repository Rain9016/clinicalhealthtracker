//
//  ActivityIndicator.swift
//  reachability
//
//  Created by chris on 17/4/17.
//  Copyright © 2017 chris hii. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator {
    static let sharedInstance: ActivityIndicator = {
        let instance = ActivityIndicator()
        return instance
    }()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var background: UIView = {
        let background = UIView()
        background.backgroundColor = .black
        background.alpha = 0.3
        return background
    }()
    
    func showActivityIndicator(uiView: UIView) {
        uiView.addSubview(background)
        uiView.addSubview(activityIndicator)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.leftAnchor.constraint(equalTo: uiView.leftAnchor).isActive = true
        background.topAnchor.constraint(equalTo: uiView.topAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: uiView.rightAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: uiView.bottomAnchor).isActive = true
        
        activityIndicator.center = uiView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        background.removeFromSuperview()
    }
}
