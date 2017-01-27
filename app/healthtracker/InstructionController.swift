//
//  InstructionController.swift
//  sendLocation
//
//  Created by untitled on 16/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class InstructionController: UIViewController {
    var questionnaire: Questionnaire!
    var currentStep: Int!
    var patientAnswers: [String:String]!
    
    ////////////////////////////
    //                        //
    //  NAVIGATION BAR STUFF  //
    //                        //
    ////////////////////////////
    
    func setupNavigationBar() {
        if (currentStep == 0) {
            self.navigationItem.hidesBackButton = true
        }
        
        self.navigationItem.title = "Step " + String(currentStep + 1) + " of " + String(questionnaire.steps.count)
        
        let cancelButton = UIBarButtonItem()
        cancelButton.title = "Cancel"
        cancelButton.style = .done
        cancelButton.target = self
        cancelButton.action = #selector(handleCancelButton)
        
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    func handleCancelButton() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    
    /////////////////////////
    //                     //
    //  SCROLL VIEW STUFF  //
    //                     //
    /////////////////////////
    
    let scrollView = UIScrollView()
    
    func setupScrollView() {
        scrollView.frame = view.bounds
    }
    
    func constrainScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true /* attach the top of the scrollview to below the navigation bar */
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true /* attach the bottom of the scrollview to above the tab bar */
    }
    
    ///////////////////
    //               //
    //  LABEL STUFF  //
    //               //
    ///////////////////
    
    let label = UILabel()
    
    func setupLabel() {
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = questionnaire.steps[currentStep].title
        label.font = label.font.withSize(20)
        
        let labelWidth: CGFloat = view.frame.size.width - 30
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        label.frame = CGRect(x: Double(15), y: Double(15), width: Double(labelSize.width), height: Double(labelSize.height))
    }
    
    var subtitleLabel = UILabel()
    
    func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        subtitleLabel.text = questionnaire.steps[currentStep].subtitle
        subtitleLabel.textColor = UIColor.gray
        
        let labelWidth: CGFloat = view.frame.size.width - 30
        let labelSize: CGSize = subtitleLabel.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        subtitleLabel.frame = CGRect(x: Double(15), y: Double(15) + Double(label.frame.size.height), width: Double(labelSize.width), height: Double(labelSize.height))
    }
    
    ////////////////////
    //                //
    //  BUTTON STUFF  //
    //                //
    ////////////////////
    
    let nextButton = UIButton()
    
    func setupNextButton() {
        if (questionnaire.steps[currentStep].subtitle != nil) {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 20, width: view.frame.size.width/3, height: 40)
        } else {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + 20, width: view.frame.size.width/3, height: 40)
        }
        
        nextButton.backgroundColor = UIColor.white
        nextButton.setTitleColor(UIColor.init(r: 14, g: 122, b: 254), for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.init(r: 14, g: 122, b: 254).cgColor
        nextButton.layer.cornerRadius = 4
        
        nextButton.addTarget(self, action: #selector(handleButtons), for: .touchUpInside)
    }
    
    let skipButton = UIButton()
    
    func setupSkipButton() {
        let skipLabel = UILabel()
        skipLabel.text = "Skip this question"
        
        let skipLabelWidth: CGFloat = view.frame.size.width
        let skipLabelSize: CGSize = skipLabel.sizeThatFits(CGSize(width: skipLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if (questionnaire.steps[currentStep].subtitle != nil) {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        } else {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        }
        
        skipButton.setTitleColor(UIColor.init(r: 14, g: 122, b: 254), for: .normal)
        skipButton.setTitle("Skip this question", for: .normal)
        
        skipButton.addTarget(self, action: #selector(handleButtons), for: .touchUpInside)
        
        if (questionnaire.steps[currentStep].isSkippable!) {
            skipButton.isEnabled = true
            skipButton.alpha = 1
        } else {
            skipButton.isEnabled = false
            skipButton.alpha = 0.2
        }
    }
    
    func handleButtons() {
        let nextStep = currentStep + 1
        
        /* set the back bar button item */
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "Back"
        navigationItem.backBarButtonItem = backBarButtonItem
        
        if (questionnaire.steps[nextStep].type == "instruction") {
            let instructionController = InstructionController()
            instructionController.questionnaire = questionnaire
            instructionController.currentStep = nextStep
            instructionController.patientAnswers = patientAnswers
            
            nextButton.isEnabled = false
            nextButton.alpha = 0.5;
            
            self.navigationController?.pushViewController(instructionController, animated: true)
        } else if (questionnaire.steps[nextStep].type == "multiple_choice") {
            let multipleChoiceController = MultipleChoiceController()
            multipleChoiceController.questionnaire = questionnaire
            multipleChoiceController.currentStep = nextStep
            multipleChoiceController.patientAnswers = patientAnswers
            
            nextButton.isEnabled = false
            nextButton.alpha = 0.5;
            
            self.navigationController?.pushViewController(multipleChoiceController, animated: true)
        } else if (questionnaire.steps[nextStep].type == "text_field") {
            let textFieldController = TextFieldController()
            textFieldController.questionnaire = questionnaire
            textFieldController.currentStep = nextStep
            textFieldController.patientAnswers = patientAnswers
            
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
            
            self.navigationController?.pushViewController(textFieldController, animated: true)
        } else if (questionnaire.steps[nextStep].type == "scale") {
            let scaleController = ScaleController()
            scaleController.questionnaire = questionnaire
            scaleController.currentStep = nextStep
            scaleController.patientAnswers = patientAnswers
            
            self.navigationController?.pushViewController(scaleController, animated: true)
        }
    }
    
    ////////////////////
    //                //
    //  MAIN PROGRAM  //
    //                //
    ////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupNavigationBar()
        
        setupScrollView()
        view.addSubview(scrollView)
        constrainScrollView()
        
        setupLabel()
        scrollView.addSubview(label)
        
        if (questionnaire.steps[currentStep].subtitle != nil) {
            setupSubtitleLabel()
            scrollView.addSubview(subtitleLabel)
        }
        
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
        
        if (questionnaire.steps[currentStep].subtitle != nil) {
            scrollViewHeight = 15 + Int(label.frame.size.height) + Int(subtitleLabel.frame.size.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        } else {
            scrollViewHeight = 15 + Int(label.frame.size.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
    }
}
