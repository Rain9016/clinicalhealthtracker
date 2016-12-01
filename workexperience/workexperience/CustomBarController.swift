//
//  CustomBarController.swift
//  workexperience
//
//  Created by untitled on 30/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = HomeController() //references QuestionnaireQuestionsController.swift
        let navigationController = UINavigationController.init(rootViewController: controller)
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(named: "homeicon")
        
        let questionnaireController1 = QuestionnaireController1()
        let navigationController2 = UINavigationController.init(rootViewController: questionnaireController1)
        navigationController2.title = "Questionnaires"
        navigationController2.tabBarItem.image = UIImage(named: "questionicon")
        
        let walkTestController = WalkTestController()
        let navigationController3 = UINavigationController.init(rootViewController: walkTestController)
        navigationController3.title = "6MWT"
        navigationController3.tabBarItem.image = UIImage(named: "walkingicon")
        
        
        viewControllers = [navigationController, navigationController2, navigationController3]
    }
}
