//
//  QuestionnaireController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class QuestionnaireController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //////////////////////
    //                  //
    //  QUESTIONNAIRES  //
    //                  //
    //////////////////////
    
    var questionnaires = [Questionnaire]()
    
    func setupQuestionnaires() {
        var step = Step(title: "", type: "")
        var answers = [String]()
        
        /* EQ-5D */
        
        var EQ5D = Questionnaire(title: "EQ-5D")
        
        step = Step(title: "Mobility", type: "multiple_choice")
        answers = [String]()
        answers.append("I have no problems in walking about")
        answers.append("I have slight problems in walking about")
        answers.append("I have moderate problems in walking about")
        answers.append("I have severe problems in walking about")
        answers.append("I am unable to walk about")
        step.multiple_choice_answers?.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Self-Care", type: "multiple_choice")
        answers = [String]()
        answers.append("I have no problems washing or dressing myself")
        answers.append("I have slight problems washing or dressing myself")
        answers.append("I have moderate problems washing or dressing myself")
        answers.append("I have severe problems washing or dressing myself")
        answers.append("I am unable to wash or dress myself")
        step.multiple_choice_answers?.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Usual Activities", type: "multiple_choice")
        step.subtitle = "(e.g. work, study, housework, family or leisure activities)"
        answers = [String]()
        answers.append("I have no problems doing my usual activities")
        answers.append("I have slight problems doing my usual activities")
        answers.append("I have moderate problems doing my usual activities")
        answers.append("I have severe problems doing my usual activities")
        answers.append("I am unable to do my usual activities")
        step.multiple_choice_answers?.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Pain/Discomfort", type: "multiple_choice")
        answers = [String]()
        answers.append("I have no pain or discomfort")
        answers.append("I have slight pain or discomfort")
        answers.append("I have moderate pain or discomfort")
        answers.append("I have severe pain or discomfort")
        answers.append("I have extreme pain or discomfort")
        step.multiple_choice_answers?.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Anxiety/Depression", type: "multiple_choice")
        answers = [String]()
        answers.append("I am not anxious or depressed")
        answers.append("I am slightly anxious or depressed")
        answers.append("I am moderately anxious or depressed")
        answers.append("I am severely anxious or depressed")
        answers.append("I am extremely anxious or depressed")
        step.multiple_choice_answers?.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "We would like to know how good or bad your health is TODAY", type: "scale")
        step.subtitle = "This scale is numbered from 0 to 100. 100 means the best health you can imagine. 0 means the worst health you can imagine. Adjust the slider to indicate how your health is TODAY."
        step.scale_min_value = 0
        step.scale_max_value = 100
        step.scale_default_value = 50
        step.scale_step = 10
        EQ5D.steps.append(step)
        
        questionnaires.append(EQ5D)
        
        /* LSA */
        
        var LSA = Questionnaire(title: "LSA")
        
        step = Step(title: "During the past 4 weeks, have you been to other rooms of your home besides the room where you sleep?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you leave the room in which you sleep?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to an area outside your home such as your porch, deck or patio, hallway of an apartment building, or garage?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to an area outside of your home?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to places in your neighbourhood, other than your own yard or apartment building?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to places in your neighbourhood?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to places outside your neighbourhood but within your town?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to places outside of your neighbourhood?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to places outside your town?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to places outside of your town?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you consider neighbourhood to be less than 1km (5-6 city blocks)?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you consider town to be less than 16km?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice_answers?.append(contentsOf: answers)
        LSA.steps.append(step)
        
        questionnaires.append(LSA)
        
        /* WHODAS 2.0 */
        
        var WHODAS = Questionnaire(title: "WHODAS 2.0")
        
        step = Step(title: "Demographic and background information", type: "instruction")
        step.subtitle = "This interview has been developed by the World Health Organization (WHO) to better understand the difficulties people may have due to their health conditions. The information that you provide in this interview is confidential and will be used only for research. The interview will take 5-10 minutes to complete."
        WHODAS.steps.append(step)
        
        step = Step(title: "What is your current living situation?", type: "multiple_choice")
        answers = [String]()
        answers.append("Independent in community")
        answers.append("Assisted living")
        answers.append("Hospitalized")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "What is your sex?", type: "multiple_choice")
        answers = [String]()
        answers.append("Male")
        answers.append("Female")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "How old are you now?", type: "text_field")
        WHODAS.steps.append(step)
        
        step = Step(title: "How many years in all did you spend studying in school, college or university?", type: "text_field")
        WHODAS.steps.append(step)
        
        step = Step(title: "What is your current marital status?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never married")
        answers.append("Currently married")
        answers.append("Separated")
        answers.append("Divorced")
        answers.append("Widowed")
        answers.append("Cohabiting")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "Which describes your main work status best?", type: "multiple_choice")
        answers = [String]()
        answers.append("Paid work")
        answers.append("Self-employed, such as own your business or farming")
        answers.append("Non-paid work, such as volunteer or charity")
        answers.append("Student")
        answers.append("Keeping house/homemaker")
        answers.append("Retired")
        answers.append("Unemployed (health reasons)")
        answers.append("Unemployed (other reasons)")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "Preamble", type: "instruction")
        step.subtitle = "The interview is about difficulties people have because of health conditions. By health condition I mean diseases or illnesses, or other health problems that may be short or long lasting; injuries; mental or emotional problems; and problems with alocohol or drugs."
        WHODAS.steps.append(step)
        
        step = Step(title: "Preamble", type: "instruction")
        step.subtitle = "Remember to keep all of your health problems in mind as you answer the questions. When I ask you about difficulties in doing an activity think about: increased effort, discomfort or pain, slowness, changes in the way you do the activity. When answering, I'd like you to think back over the past 30 days. I would also like you to answer these questions thinking about how much difficulty you have had, on average, over the past 30 days, while doing the activity as you usually do it."
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in standing for long periods such as 30 minutes?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in taking care of your household responsibilities?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in learning a new task?", type: "multiple_choice")
        step.subtitle = "e.g. learning how to get to a new place"
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much of a problem did you have joining in community activities in the same way as everyone else can?", type: "multiple_choice")
        step.subtitle = "e.g. festivities, religious or other activities"
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much have you been emotionally affected by your health problems?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in concentrating on doing something for ten minutes?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in walking a long distance such as a kilometre (or equivalent)?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in washing your whole body?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in getting dressed?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in dealing with people you do not know?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in maintaining a friendship?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in your day-to-day work or school?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice_answers?.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "Overall, in the past 30 days, how many days were these difficulties present?", type: "text_field")
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, for how many days were you totally unable to carry out your usual activities or work because of any health condition?", type: "text_field")
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, not counting the days that you were totally unable, for how many days did you cut back or reduce your usual activities or work because of any health condition?", type: "text_field")
        WHODAS.steps.append(step)
        
        questionnaires.append(WHODAS)
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
    
    ////////////////////////
    //                    //
    //  TABLE VIEW STUFF  //
    //                    //
    ////////////////////////
    
    var selectedQuestionnaire = 0
    let tableView = UITableView()
    
    func setupTableView() {
        tableView.frame = view.bounds /* this is needed for tableView.layoutIfNeeded() to work, I'm not sure why */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        
        /* calculate and set tableview height */
        tableView.layoutIfNeeded()
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: tableView.contentSize.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionnaires.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questionnaires[indexPath.row].title
        cell.textLabel?.numberOfLines = 0;
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
        selectedQuestionnaire = indexPath.row
        beginButton.isEnabled = true
        beginButton.alpha = 1
    }
    
    ////////////////////
    //                //
    //  BUTTON STUFF  //
    //                //
    ////////////////////
    
    let beginButton = UIButton()
    
    func setupBeginButton() {
        beginButton.frame = CGRect(x: view.frame.size.width/3, y: tableView.contentSize.height + 20, width: view.frame.size.width/3, height: 40)
        
        beginButton.backgroundColor = UIColor.white
        beginButton.setTitleColor(UIColor.init(r: 14, g: 122, b: 254), for: .normal)
        beginButton.setTitle("Begin", for: .normal)
        beginButton.layer.borderWidth = 1
        beginButton.layer.borderColor = UIColor.init(r: 14, g: 122, b: 254).cgColor
        beginButton.layer.cornerRadius = 4
        
        beginButton.addTarget(self, action: #selector(handleBeginButton), for: .touchUpInside)
        
        beginButton.isEnabled = false
        beginButton.alpha = 0.2
    }
    
    func handleBeginButton() {
        let questionnaire = questionnaires[selectedQuestionnaire]
        let currentStep = 0
        
        if (questionnaire.steps[currentStep].type == "instruction") {
            let instructionController = InstructionController()
            instructionController.questionnaire = questionnaire
            instructionController.currentStep = currentStep
            instructionController.patientAnswers = [:]
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5;
            
            self.navigationController?.pushViewController(instructionController, animated: true)
        } else if (questionnaire.steps[currentStep].type == "multiple_choice") {
            let multipleChoiceController = MultipleChoiceController()
            multipleChoiceController.questionnaire = questionnaire
            multipleChoiceController.currentStep = currentStep
            multipleChoiceController.patientAnswers = [:]
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5
            
            self.navigationController?.pushViewController(multipleChoiceController, animated: true)
        } else if (questionnaire.steps[currentStep].type == "text_field") {
            let textFieldController = TextFieldController()
            textFieldController.questionnaire = questionnaire
            textFieldController.currentStep = currentStep
            textFieldController.patientAnswers = [:]
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5
            
            self.navigationController?.pushViewController(textFieldController, animated: true)
        } else if (questionnaire.steps[currentStep].type == "scale") {
            let scaleController = ScaleController()
            scaleController.questionnaire = questionnaire
            scaleController.currentStep = currentStep
            scaleController.patientAnswers = [:]
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5;
            
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
        
        setupQuestionnaires()
        
        setupScrollView()
        view.addSubview(scrollView)
        constrainScrollView()
        
        setupTableView()
        scrollView.addSubview(tableView)
        
        setupBeginButton()
        scrollView.addSubview(beginButton)
        
        ///////////////////////////////////
        //                               //
        //  SET SCROLLVIEW CONTENT SIZE  //
        //                               //
        ///////////////////////////////////
        
        let scrollViewHeight = tableView.contentSize.height + 70
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
    }
}
