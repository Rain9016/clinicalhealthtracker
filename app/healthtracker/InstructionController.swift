//
//  InstructionController.swift
//  sendLocation
//
//  Created by untitled on 16/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class InstructionController: StepController {
    ///////////////////
    //               //
    //  LABEL STUFF  //
    //               //
    ///////////////////
    
    let content_label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setup_content_label() {
        content_label.numberOfLines = 0
        content_label.lineBreakMode = NSLineBreakMode.byWordWrapping
        content_label.text = survey.steps[currentStep].instruction?.content
        
        let labelWidth: CGFloat = view.frame.size.width - 30
        let labelSize: CGSize = content_label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if (survey.steps[currentStep].subtitle != nil) {
            content_label.frame = CGRect(x: 15, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 20, width: labelSize.width, height: labelSize.height)
        } else {
            content_label.frame = CGRect(x: 15, y: 15 + label.frame.size.height + 20, width: labelSize.width, height: labelSize.height)
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
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 20 + content_label.frame.size.height + 20, width: view.frame.size.width/3, height: 40)
        } else {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + 20 + content_label.frame.size.height + 20, width: view.frame.size.width/3, height: 40)
        }
        
        nextButton.backgroundColor = UIColor.white
        nextButton.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        nextButton.layer.cornerRadius = 4
        
        nextButton.addTarget(self, action: #selector(handleButtons), for: .touchUpInside)
    }
    
    let skipButton = UIButton()
    
    func setupSkipButton() {
        let skipLabel = UILabel()
        skipLabel.text = "Skip this question"
        
        let skipLabelWidth: CGFloat = view.frame.size.width
        let skipLabelSize: CGSize = skipLabel.sizeThatFits(CGSize(width: skipLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if (survey.steps[currentStep].subtitle != nil) {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 20 + content_label.frame.size.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        } else {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 20 + content_label.frame.size.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        }
        
        skipButton.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        skipButton.setTitle("Skip this question", for: .normal)
        
        skipButton.addTarget(self, action: #selector(handleButtons), for: .touchUpInside)
        
        if (survey.steps[currentStep].isSkippable) {
            skipButton.isEnabled = true
            skipButton.alpha = 1
        } else {
            skipButton.isEnabled = false
            skipButton.alpha = 0.2
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
        
        if (survey.steps[currentStep].subtitle != nil) {
            setupSubtitleLabel()
            scrollView.addSubview(subtitleLabel)
        }
        
        setup_content_label()
        scrollView.addSubview(content_label)
        
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
            scrollViewHeight = 15 + Int(label.frame.size.height) + Int(subtitleLabel.frame.size.height) + 20 + Int(content_label.frame.size.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        } else {
            scrollViewHeight = 15 + Int(label.frame.size.height) + 20 + Int(content_label.frame.size.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
    }
}
