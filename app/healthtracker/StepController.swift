//
//  StepController.swift
//  healthtracker
//
//  Created by untitled on 15/2/17.
//
//

import UIKit

class StepController: UIViewController {
    var survey: Survey!
    var currentStep: Int!
    var answers: [[String:String]]!
    
    ////////////////////////////
    //                        //
    //  NAVIGATION BAR STUFF  //
    //                        //
    ////////////////////////////
    
    func setupNavigationBar() {
        if (currentStep == 0) {
            self.navigationItem.hidesBackButton = true
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.init(r: 204, g: 0, b: 0)
        
        self.navigationItem.title = "Step " + String(currentStep + 1) + " of " + String(survey.steps.count)
        
        let cancelButton = UIBarButtonItem()
        cancelButton.title = "Cancel"
        cancelButton.style = .done
        cancelButton.target = self
        cancelButton.action = #selector(cancelButtonAction)
        
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
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
        
        if (survey.steps[currentStep].isSkippable) {
            label.text = survey.steps[currentStep].title + " Otherwise if N/A, press \"Skip this question\" at the bottom of the page."
        } else {
            label.text = survey.steps[currentStep].title
        }
        label.font = label.font.withSize(20)
        
        let labelWidth: CGFloat = view.frame.size.width - 30
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        label.frame = CGRect(x: Double(15), y: Double(15), width: Double(labelSize.width), height: Double(labelSize.height))
    }
    
    var subtitleLabel = UILabel()
    
    func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        subtitleLabel.text = survey.steps[currentStep].subtitle
        subtitleLabel.textColor = UIColor.gray
        
        let labelWidth: CGFloat = view.frame.size.width - 30
        let labelSize: CGSize = subtitleLabel.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        subtitleLabel.frame = CGRect(x: Double(15), y: Double(15) + Double(label.frame.size.height), width: Double(labelSize.width), height: Double(labelSize.height))
    }
    
    ///////////////////////////
    //                       //
    //  BUTTON ACTION STUFF  //
    //                       //
    ///////////////////////////
    
    func handleButtons() {
        let nextStep = currentStep + 1
        guard nextStep < survey.steps.count else {
            let data_to_send = DataToSend.sharedInstance
            data_to_send.survey_data["survey_data"]?.append(contentsOf: answers)
            
            let activityCompleteController = ActivityCompleteController()
            activityCompleteController.activity = "survey"
            
            self.navigationController?.pushViewController(activityCompleteController, animated: true)
            return
        }
        
        /* set the back bar button item */
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "Back"
        navigationItem.backBarButtonItem = backBarButtonItem
        
        if (survey.steps[nextStep].type == "instruction") {
            let instructionController = InstructionController()
            instructionController.survey = survey
            instructionController.currentStep = nextStep
            instructionController.answers = answers
            
            self.navigationController?.pushViewController(instructionController, animated: true)
        } else if (survey.steps[nextStep].type == "multiple_choice") {
            let multipleChoiceController = MultipleChoiceController()
            multipleChoiceController.survey = survey
            multipleChoiceController.currentStep = nextStep
            multipleChoiceController.answers = answers
            
            self.navigationController?.pushViewController(multipleChoiceController, animated: true)
        } else if (survey.steps[nextStep].type == "text_field") {
            let textFieldController = TextFieldController()
            textFieldController.survey = survey
            textFieldController.currentStep = nextStep
            textFieldController.answers = answers
            
            self.navigationController?.pushViewController(textFieldController, animated: true)
        } else if (survey.steps[nextStep].type == "scale") {
            let scaleController = ScaleController()
            scaleController.survey = survey
            scaleController.currentStep = nextStep
            scaleController.answers = answers
            
            self.navigationController?.pushViewController(scaleController, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
