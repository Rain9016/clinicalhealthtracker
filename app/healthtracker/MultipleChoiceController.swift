//
//  surveyController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class MultipleChoiceController: StepController, UITableViewDelegate, UITableViewDataSource {
    
    ////////////////////////
    //                    //
    //  TABLE VIEW STUFF  //
    //                    //
    ////////////////////////
    
    var selectedAnswer = 0
    let tableView = UITableView()
    
    func setupTableView() {
        tableView.frame = view.bounds /* this is needed for tableView.layoutIfNeeded() to work, I'm not sure why */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        
        tableView.layoutIfNeeded()
        
        if (survey.steps[currentStep].subtitle != nil) {
            tableView.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 15, width: view.frame.width, height: tableView.contentSize.height)
        } else {
            tableView.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 15, width: view.frame.width, height: tableView.contentSize.height) /* the y co-ordinate is set to "15 + label.frame.size.height + 15" as we want 15 pixels of padding on the top and bottom */
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (survey.steps[currentStep].multiple_choice?.answers.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = survey.steps[currentStep].multiple_choice?.answers[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswer = indexPath.row
        nextButton.isEnabled = true
        nextButton.alpha = 1
    }
    
    ////////////////////
    //                //
    //  BUTTON STUFF  //
    //                //
    ////////////////////
    
    let nextButton = UIButton()
    
    func setupNextButton() {
        if (survey.steps[currentStep].subtitle != nil) {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 15 + tableView.contentSize.height + 20, width: view.frame.size.width/3, height: 40)
        } else {
            nextButton.frame = CGRect(x: view.frame.size.width/3, y: 15 + label.frame.size.height + 15 + tableView.contentSize.height + 20, width: view.frame.size.width/3, height: 40)
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
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + subtitleLabel.frame.size.height + 15 + tableView.contentSize.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
        } else {
            skipButton.frame = CGRect(x: 0, y: 15 + label.frame.size.height + 15 + tableView.contentSize.height + 20 + nextButton.frame.size.height + 5, width: view.frame.size.width, height: skipLabelSize.height)
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
    
    @objc func handleNext() {
        guard let uniqueId = UserDefaults.standard.object(forKey: "uniqueId") as? String else {
            return
        }
        
        let title = survey.title
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dateFormatter.string(from: Date())
            
        let question = survey.steps[currentStep].title
        guard let answer = survey.steps[currentStep].multiple_choice?.answers[selectedAnswer] else {
            return
        }
        
        let entry = SurveyData(uniqueId: uniqueId, time: time, title: title, question: question, answer: answer)
        answers.append(entry)
        
        handleButtons()
    }
    
    @objc func handleSkip() {
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
        
        setupTableView()
        scrollView.addSubview(tableView)
        
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
            scrollViewHeight = 15 + Int(label.frame.size.height) + Int(subtitleLabel.frame.size.height) + 15 + Int(tableView.contentSize.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        } else {
            scrollViewHeight = 15 + Int(label.frame.size.height) + 15 + Int(tableView.contentSize.height) + 20 + 40 + 5 + Int(skipButton.frame.size.height) + 20
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
    }
}
