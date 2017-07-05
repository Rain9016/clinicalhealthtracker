//
//  PreludeController.swift
//  healthtracker
//
//  Created by untitled on 15/2/17.
//
//

import UIKit

class WalkTestPreludeController: UIViewController {

    let instructions_label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "If you are unfamiliar with the walk test, please press the \"Instructions\" button below."
        return label
    }()
    
    let begin_label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "Otherwise you can begin the walk test by pressing the \"Begin\" button below. You can cancel the walk test at any time by pressing the \"Cancel\" button in the top right-hand corner of the screen."
        return label
    }()
    
    let instructions_button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        button.setTitle("Instructions", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(instructionsButtonAction), for: .touchUpInside)
        return button
    }()
    
    let begin_button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(r: 204, g: 0, b: 0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Begin", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(beginButtonAction), for: .touchUpInside)
        return button
    }()

    func instructionsButtonAction() {
        let instructionController = WalkTestInstructionController()
        instructionController.page = 0
        
        let newNavigationController = UINavigationController(rootViewController: instructionController)
        present(newNavigationController, animated: true, completion: nil)
    }
    
    func beginButtonAction() {
        let walkTestController = WalkTestController()
        let newNavigationController = UINavigationController(rootViewController: walkTestController)
        present(newNavigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Walk Test"
        view.backgroundColor = .white
        
        view.addSubview(instructions_label)
        view.addSubview(instructions_button)
        view.addSubview(begin_label)
        view.addSubview(begin_button)

        let offset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 20
        
        instructions_label.translatesAutoresizingMaskIntoConstraints = false
        instructions_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructions_label.topAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
        instructions_label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        instructions_button.translatesAutoresizingMaskIntoConstraints = false
        instructions_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructions_button.topAnchor.constraint(equalTo: instructions_label.bottomAnchor, constant: 20).isActive = true
        instructions_button.widthAnchor.constraint(equalToConstant: 140).isActive = true
        instructions_button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        begin_label.translatesAutoresizingMaskIntoConstraints = false
        begin_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        begin_label.topAnchor.constraint(equalTo: instructions_button.bottomAnchor, constant: 20).isActive = true
        begin_label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        begin_button.translatesAutoresizingMaskIntoConstraints = false
        begin_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        begin_button.topAnchor.constraint(equalTo: begin_label.bottomAnchor, constant: 20).isActive = true
        begin_button.widthAnchor.constraint(equalToConstant: 140).isActive = true
        begin_button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
