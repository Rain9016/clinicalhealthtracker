//
//  TextAnswerController.swift
//  sendLocation
//
//  Created by untitled on 16/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class TextFieldController: StepController, UITextFieldDelegate {
    
    ////////////////////////
    //                    //
    //  TEXT FIELD STUFF  //
    //                    //
    ////////////////////////
    
    let textField = UITextField()
    
    func setupTextField() {
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        
        let tableView = UITableView()
        
        if (survey.steps[currentStep].subtitle != nil) {
            textField.frame = CGRect(x: 15, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 15, width: view.frame.width - 15, height: 44)
        } else {
            textField.frame = CGRect(x: 15, y: 15 + label.frame.size.height + 15, width: view.frame.width - 15, height: 44)
        }
        textField.placeholder = "Tap to write"
        if (survey.steps[currentStep].type == "numeric") {
            textField.keyboardType = .numberPad
        }
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: textField.frame.width, height: 1)
        topBorder.backgroundColor = tableView.separatorColor?.cgColor
        textField.layer.addSublayer(topBorder)
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: textField.frame.height-1, width: textField.frame.width, height: 1)
        bottomBorder.backgroundColor = tableView.separatorColor?.cgColor
        textField.layer.addSublayer(bottomBorder)
    }
    
    /* http://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes */
    func textFieldDidChange() {
        if (textField.text?.isEmpty)! {
            nextButton.isEnabled = false
            nextButton.alpha = 0.2
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = 1
        }
    }
    ////////////////////
    //                //
    //  BUTTON STUFF  //
    //                //
    ////////////////////
    
    let nextButton = UIButton()
    
    func setupNextButton() {
        if (survey.steps[currentStep].subtitle != nil) {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 15 + textField.frame.height + 20, width: view.frame.size.width/3, height: 40)
        } else {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + 15 + textField.frame.height + 20, width: view.frame.size.width/3, height: 40)
        }
        
        nextButton.backgroundColor = UIColor.white
        nextButton.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        nextButton.layer.cornerRadius = 4
        
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        nextButton.isEnabled = false
        nextButton.alpha = 0.2
    }
    
    let skipButton = UIButton()
    
    func setupSkipButton() {
        let skipLabel = UILabel()
        skipLabel.text = "Skip this question"
        
        let skipLabelWidth: CGFloat = view.frame.size.width
        let skipLabelSize: CGSize = skipLabel.sizeThatFits(CGSize(width: skipLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if (survey.steps[currentStep].subtitle != nil) {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 15 + textField.frame.size.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        } else {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 15 + textField.frame.size.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        }
        
        skipButton.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        skipButton.setTitle("Skip this question", for: .normal)
        
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        if survey.steps[currentStep].isSkippable {
            skipButton.isEnabled = true
            skipButton.alpha = 1
        } else {
            skipButton.isEnabled = false
            skipButton.alpha = 0.2
        }
    }
    
    func handleNext() {
        let unique_id = UserDefaults.standard.object(forKey: "unique_id") as? String
        let title = survey.title
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dateFormatter.string(from: Date())
            
        let question = survey.steps[currentStep].title
        let answer = textField.text
            
        answers.append(["unique_id":unique_id!, "title":title, "time":time, "question":question, "answer":answer!])
        
        handleButtons()
    }
    
    func handleSkip() {
        handleButtons()
    }
    
    ////////////////////
    //                //
    //  MAIN PROGRAM  //
    //                //
    ////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.textField.delegate = self // used to hide the keyboard when user presses "return" on textFieldShouldReturn()
        
        setupNavigationBar()
        
        setupScrollView()
        view.addSubview(scrollView)
        constrainScrollView()
        
        setupLabel()
        scrollView.addSubview(label)
        
        if (survey.steps[currentStep].subtitle != nil) {
            setupSubtitleLabel()
            scrollView.addSubview(subtitleLabel)
        }
        
        setupTextField()
        scrollView.addSubview(textField)
        
        setupNextButton()
        scrollView.addSubview(nextButton)
        
        setupSkipButton()
        scrollView.addSubview(skipButton)
        
        ///////////////////////////////////
        //                               //
        //  SET SCROLLVIEW CONTENT SIZE  //
        //                               //
        ///////////////////////////////////
        
        var scrollViewHeight = 0
        
        if (survey.steps[currentStep].subtitle != nil) {
            scrollViewHeight = 15 + Int(label.frame.size.height) + Int(subtitleLabel.frame.size.height) + 15 + Int(textField.frame.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        } else {
            scrollViewHeight = 15 + Int(label.frame.size.height) + 15 + Int(textField.frame.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
        
        ////////////////////////
        //                    //
        //  DISMISS KEYBOARD  //
        //                    //
        ////////////////////////

        // from: https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
}
