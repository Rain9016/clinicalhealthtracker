//
//  CustomTabBarController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.init(r: 204, g: 0, b: 0)
        
        //setup
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        label.font = UIFont.init(name: "FontAwesome", size: 33)
        label.text = "\u{f015}"
        
        let homeImage = UIImage.imageWithLabel(label: label)
        
        let homeController = HomeController()
        let navHomeController = UINavigationController(rootViewController: homeController)
        navHomeController.title = "Home"
        navHomeController.tabBarItem.image = homeImage
        
        label.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        label.font = UIFont.init(name: "FontAwesome", size: 35)
        label.text = "\u{f128}"
        let questionnaireImage = UIImage.imageWithLabel(label: label)
        
        let surveyController = SurveyController()
        let navSurveyController = UINavigationController(rootViewController: surveyController)
        navSurveyController.title = "Surveys"
        navSurveyController.tabBarItem.image = questionnaireImage
        
        label.frame = CGRect(x: 0, y: 0, width: 17, height: 30)
        label.font = UIFont.init(name: "Ionicons", size: 33)
        label.text = "\u{f3bb}"
        let walkTestImage = UIImage.imageWithLabel(label: label)
        
        let walkTestController = WalkTestPreludeController()
        let navWalkTestController = UINavigationController(rootViewController: walkTestController)
        navWalkTestController.title = "Walk Test"
        navWalkTestController.tabBarItem.image = walkTestImage
        
        viewControllers = [navHomeController, navSurveyController, navWalkTestController]
    }
}
