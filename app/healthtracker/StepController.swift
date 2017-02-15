//
//  StepController.swift
//  healthtracker
//
//  Created by untitled on 15/2/17.
//
//

import UIKit

class StepController: UIViewController {
    var questionnaire: Questionnaire!
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
    
    ///////////////////////////
    //                       //
    //  BUTTON ACTION STUFF  //
    //                       //
    ///////////////////////////
    
    func handleButtons() {
        let nextStep = currentStep + 1
        guard nextStep < questionnaire.steps.count else {
            let data_to_send = DataToSend.sharedInstance
            data_to_send.questionnaire_data["questionnaire_data"]?.append(contentsOf: answers)
            
            let activityCompleteController = ActivityCompleteController()
            activityCompleteController.activity = "questionnaire"
            
            activityCompleteController.navigationItem.hidesBackButton = true
            let done_button = UIBarButtonItem()
            done_button.title = "Done"
            done_button.style = .done
            done_button.target = self
            done_button.action = #selector(handle_done_button)
            activityCompleteController.navigationItem.rightBarButtonItem = done_button
            
            self.navigationController?.pushViewController(activityCompleteController, animated: true)
            return
        }
        
        /* set the back bar button item */
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "Back"
        navigationItem.backBarButtonItem = backBarButtonItem
        
        if (questionnaire.steps[nextStep].type == "instruction") {
            let instructionController = InstructionController()
            instructionController.questionnaire = questionnaire
            instructionController.currentStep = nextStep
            instructionController.answers = answers
            
            self.navigationController?.pushViewController(instructionController, animated: true)
        } else if (questionnaire.steps[nextStep].type == "multiple_choice") {
            let multipleChoiceController = MultipleChoiceController()
            multipleChoiceController.questionnaire = questionnaire
            multipleChoiceController.currentStep = nextStep
            multipleChoiceController.answers = answers
            
            self.navigationController?.pushViewController(multipleChoiceController, animated: true)
        } else if (questionnaire.steps[nextStep].type == "text_field") {
            let textFieldController = TextFieldController()
            textFieldController.questionnaire = questionnaire
            textFieldController.currentStep = nextStep
            textFieldController.answers = answers
            
            self.navigationController?.pushViewController(textFieldController, animated: true)
        } else if (questionnaire.steps[nextStep].type == "scale") {
            let scaleController = ScaleController()
            scaleController.questionnaire = questionnaire
            scaleController.currentStep = nextStep
            scaleController.answers = answers
            
            self.navigationController?.pushViewController(scaleController, animated: true)
        }
    }
    
    func handle_done_button() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
