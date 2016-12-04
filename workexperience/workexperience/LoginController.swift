//
//  LoginController.swift
//  workexperience
//
//  Created by untitled on 30/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.cornerRadius = 5 //make the edges curved.
        //view.layer.masksToBounds = true //need this for cornerRadius to take effect.
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    func setupInputsView() {
        //need x, y, width, height contraints
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsView.addSubview(nameTextField)
        setupNameTextField()
    }
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Unique ID"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func setupNameTextField() {
        //need x, y, width, height contraints
        nameTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor).isActive = true
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    func setupLoginButton() {
        //need x, y, width, height contraints
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //////////////////
        //  SETUP VIEW  //
        //////////////////
        view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
        ////////////////////
        //  ADD CONTENTS  //
        ////////////////////
        view.addSubview(inputsView)
        setupInputsView()
        
        view.addSubview(loginButton)
        setupLoginButton()
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

//hide keyboard when screen is pressed (http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift)
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
