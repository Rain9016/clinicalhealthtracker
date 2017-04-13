//
//  ScaleAnswerController.swift
//  sendLocation
//
//  Created by untitled on 16/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class ScaleController: StepController {
    
    ////////////////////
    //                //
    //  SLIDER STUFF  //
    //                //
    ////////////////////
    
    let answerLabel = UILabel()
    
    func setupAnswerLabel() {
        answerLabel.text = String((survey.steps[currentStep].scale?.default_value)!)
        answerLabel.font = label.font.withSize(30)
        answerLabel.textAlignment = .center
        
        let labelSize: CGSize = answerLabel.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if (survey.steps[currentStep].subtitle != nil) {
            answerLabel.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 30, width: view.frame.size.width, height: labelSize.height)
        } else {
            answerLabel.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 30, width: view.frame.size.width, height: labelSize.height)
        }
    }
    
    let minValueLabel = UILabel()
    
    func setupMinValueLabel() {
        minValueLabel.text = String((survey.steps[currentStep].scale?.min_value)!)
        minValueLabel.textAlignment = .center
        
        let labelSize: CGSize = minValueLabel.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if (survey.steps[currentStep].subtitle != nil) {
            minValueLabel.frame = CGRect(x: 15, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 30 + answerLabel.frame.size.height + 10, width: labelSize.width, height: labelSize.height)
        } else {
            minValueLabel.frame = CGRect(x: 15, y: 15 + label.frame.size.height + 30 + answerLabel.frame.size.height + 10, width: labelSize.width, height: labelSize.height)
        }
    }
    
    let maxValueLabel = UILabel()
    
    func setupMaxValueLabel() {
        maxValueLabel.text = String((survey.steps[currentStep].scale?.max_value)!)
        maxValueLabel.textAlignment = .center
        
        let labelSize: CGSize = maxValueLabel.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if (survey.steps[currentStep].subtitle != nil) {
            maxValueLabel.frame = CGRect(x: view.frame.size.width - 15 - labelSize.width, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 30 + answerLabel.frame.size.height + 10, width: labelSize.width, height: labelSize.height)
        } else {
            maxValueLabel.frame = CGRect(x: view.frame.size.width - 15 - labelSize.width, y: 15 + label.frame.size.height + 30 + answerLabel.frame.size.height + 10, width: labelSize.width, height: labelSize.height)
        }
    }
    
    let scale = UISlider()
    
    func setupScale() {
        let scaleHeight: CGFloat = minValueLabel.frame.size.height
        
        if (survey.steps[currentStep].subtitle != nil) {
            scale.frame = CGRect(x: 15 + minValueLabel.frame.size.width, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 30 + answerLabel.frame.size.height + 10, width: view.frame.width - 15 - minValueLabel.frame.size.width - 15 - maxValueLabel.frame.size.width, height: scaleHeight)
        } else {
            scale.frame = CGRect(x: 15 + minValueLabel.frame.size.width, y: 15 + label.frame.size.height + 30 + answerLabel.frame.size.height + 10, width: view.frame.width - 15 - minValueLabel.frame.size.width - 15 - maxValueLabel.frame.size.width, height: scaleHeight)
        }
        
        scale.minimumValue = Float((survey.steps[currentStep].scale?.min_value)!)
        scale.maximumValue = Float((survey.steps[currentStep].scale?.max_value)!)
        scale.value = Float((survey.steps[currentStep].scale?.default_value)!)
        scale.isContinuous = true
        
        /////////////////////////
        //                     //
        //  SLIDER APPEARANCE  //
        //                     //
        /////////////////////////
        
        /* this bit removes the "track" from the slider */
        let blankImage = UIImage()
        scale.setMinimumTrackImage(blankImage, for: .normal)
        scale.setMaximumTrackImage(blankImage, for: .normal)
        
        /* i think the diameter "thumb image" of the slider is 30px, thus i offset the x co-ord by 15px */
        let leftTick = CALayer()
        leftTick.frame = CGRect(x: 15, y: scale.frame.size.height/2 - 5, width: 1, height: 10)
        leftTick.backgroundColor = UIColor.black.cgColor
        scale.layer.addSublayer(leftTick)
        
        let scaleMaxValue = survey.steps[currentStep].scale?.max_value
        let numberOfTicks = Float(scaleMaxValue!)/Float((survey.steps[currentStep].scale?.step)!)
        let sizeBetweenTicks = Float(scale.frame.size.width - 30)/numberOfTicks
        var currentPosition = 15 + sizeBetweenTicks
        
        while (currentPosition < Float(scale.frame.size.width - 15)) {
            let tick = CALayer()
            tick.frame = CGRect(x: CGFloat(currentPosition), y: scale.frame.size.height/2 - 5, width: 1, height: 10)
            tick.backgroundColor = UIColor.black.cgColor
            scale.layer.addSublayer(tick)
            
            currentPosition = currentPosition + sizeBetweenTicks
        }
        
        let rightTick = CALayer()
        rightTick.frame = CGRect(x: scale.frame.size.width - 15, y: scale.frame.size.height/2 - 5, width: 1, height: 10)
        rightTick.backgroundColor = UIColor.black.cgColor
        scale.layer.addSublayer(rightTick)
        
        let track = CALayer()
        track.frame = CGRect(x: 15, y: scale.frame.size.height/2 - 0.5, width: scale.frame.size.width - 30, height: 1)
        track.backgroundColor = UIColor.black.cgColor
        scale.layer.addSublayer(track)
        
        scale.addTarget(self, action: #selector(scaleValueDidChange), for: .valueChanged)
    }
    
    func scaleValueDidChange() {
        let scaleStep = survey.steps[currentStep].scale?.step
        let roundedValue = round(scale.value / Float(scaleStep!)) * Float(scaleStep!)
        scale.value = roundedValue
        
        answerLabel.text = "\(Int(scale.value))"
        
        nextButton.isEnabled = true
        nextButton.alpha = 1
    }
    
    ////////////////////
    //                //
    //  BUTTON STUFF  //
    //                //
    ////////////////////
    
    let nextButton = UIButton()
    var extraSpaceAboveButton: CGFloat!
    
    func setupNextButton() {
        //extraSpaceAboveButton = (minValueLabel.frame.size.height/2) + CGFloat(15)
        
        if (survey.steps[currentStep].subtitle != nil) {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 30 + answerLabel.frame.size.height + 10 + minValueLabel.frame.height + 45, width: view.frame.size.width/3, height: 40)
        } else {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + 30 + answerLabel.frame.size.height + 10 + minValueLabel.frame.height + 45, width: view.frame.size.width/3, height: 40)
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
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 30 + answerLabel.frame.size.height + 10 + minValueLabel.frame.size.height + 45 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        } else {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 30 + answerLabel.frame.size.height + 10 + minValueLabel.frame.size.height + 45 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        }
        
        skipButton.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        skipButton.setTitle("Skip this question", for: .normal)
        
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        if (survey.steps[currentStep].isSkippable) {
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
        let answer: String = String(scale.value)
            
        answers.append(["unique_id":unique_id!, "title":title, "time":time, "question":question, "answer":answer])
        
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
        
        setupAnswerLabel()
        scrollView.addSubview(answerLabel)
        
        setupMinValueLabel()
        scrollView.addSubview(minValueLabel)
        
        setupMaxValueLabel()
        scrollView.addSubview(maxValueLabel)
        
        setupScale()
        scrollView.addSubview(scale)
        
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
            scrollViewHeight = 15 + Int(label.frame.size.height) + Int(subtitleLabel.frame.size.height) + 30 + Int(answerLabel.frame.size.height) + 10 + Int(scale.frame.height) + 45 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        } else {
            scrollViewHeight = 15 + Int(label.frame.size.height) + 30 + Int(answerLabel.frame.size.height) + 10 + Int(scale.frame.height) + 40 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
    }
}
