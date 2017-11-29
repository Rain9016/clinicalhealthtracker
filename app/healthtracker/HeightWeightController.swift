//
//  HeightWeightController.swift
//  healthtracker
//
//  Created by chris on 27/7/17.
//
//

import UIKit

class HeightWeightController: UIViewController, UITextFieldDelegate {
    var dataToSend = DataToSend.sharedInstance
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "Please enter your height (in metres) and weight (in kilograms) in the text fields below."
        return label
    }()
    
    let heightField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.placeholder = "Enter your height in m"
        textField.font = textField.font?.withSize(14)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let weightField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.placeholder = "Enter your weight in kg"
        textField.font = textField.font?.withSize(14)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.init(r: 204, g: 0, b: 0)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        heightField.delegate = self // used to hide the keyboard when user presses "return" on textFieldShouldReturn(), also to allow only 1 decimal point
        weightField.delegate = self // used to hide the keyboard when user presses "return" on textFieldShouldReturn(), also to allow only 1 decimal point
        
        view.addSubview(heightField)
        heightField.translatesAutoresizingMaskIntoConstraints = false
        heightField.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heightField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heightField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        heightField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: heightField.topAnchor, constant: -20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        
        view.addSubview(weightField)
        weightField.translatesAutoresizingMaskIntoConstraints = false
        weightField.topAnchor.constraint(equalTo: heightField.bottomAnchor, constant: 10).isActive = true
        weightField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        weightField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: weightField.bottomAnchor, constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        ////////////////////////
        //                    //
        //  DISMISS KEYBOARD  //
        //                    //
        ////////////////////////
        
        // from: https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap(gesture: UITapGestureRecognizer) {
        heightField.resignFirstResponder()
        weightField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    //////////////////////////////////
    //                              //
    //  ALLOW ONLY 1 DECIMAL POINT  //
    //                              //
    //////////////////////////////////
    
    //from: https://stackoverflow.com/questions/27883171/how-do-you-limit-only-1-decimal-entry-in-a-uitextfield-in-swift-for-ios8
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countdots = textField.text!.components(separatedBy: ".").count - 1
        
        if countdots > 0 && string == "."
        {
            return false
        }
        return true
    }
    
    //////////////
    //          //
    //  SUBMIT  //
    //          //
    //////////////
    
    @objc func handleButton() {
        if heightField.text == "" || weightField.text == "" {
            sendAlert(title: "Error", message: "Please fill out all fields")
        } else {
            let unique_id = UserDefaults.standard.object(forKey: "unique_id") as? String
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let current_time = dateFormatter.string(from: Date())
            
            let height = heightField.text!
            let weight = weightField.text!
            
            dataToSend.height_weight_data["height_weight_data"]?.append(["unique_id":unique_id!, "time":current_time, "height":height, "weight":weight])
            
            //send data
            send_data(type: "height_weight")
            
            //dismiss view
            UserDefaults.standard.set(true, forKey: "heightWeightSubmitted")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
