//
//  QuestionnaireController1.swift
//  workexperience
//
//  Created by untitled on 30/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class QuestionnaireController1: UITableViewController {
    ////////////////////////////
    //                        //
    //  SETUP QUESTIONNAIRES  //
    //                        //
    ////////////////////////////

    var questionnaires = [Questionnaire]()
    var q = Questionnaire()
    var questions = [Questions]()
    var question = Questions()
    var answers = [String]()
    
    func setupQuestionnaires() {
        /////////////
        //         //
        //  EQ-5D  //
        //         //
        /////////////
        
        q = Questionnaire()
        
        q.name = "EQ-5D"
        //QUESTION 1
        question = Questions()
    
        question.question = "Mobility"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("I have no problems in walking about")
        answers.append("I have slight problems in walking about")
        answers.append("I have moderate problems in walking about")
        answers.append("I have severe problems in walking about")
        answers.append("I am unable to walk about")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 2
        
        question = Questions()
        
        question.question = "Self-Care"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("I have no problems washing or dressing myself")
        answers.append("I have slight problems washing or dressing myself")
        answers.append("I have moderate problems washing or dressing myself")
        answers.append("I have severe problems washing or dressing myself")
        answers.append("I am unable to wash or dress myself")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 3
        
        question = Questions()
        
        question.question = "Usual activities (e.g. work, study, housework, family or leisure activities"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("I have no problems doing my usual activities")
        answers.append("I have slight problems doing my usual activities")
        answers.append("I have moderate problems doing my usual activities")
        answers.append("I have severe problems doing my usual activities")
        answers.append("I am unable to do my usual activities")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 4
        
        question = Questions()
        
        question.question = "Pain/Discomfort"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("I have no pain or discomfort")
        answers.append("I have slight pain or discomfort")
        answers.append("I have moderate pain or discomfort")
        answers.append("I have severe pain or discomfort")
        answers.append("I have extreme pain or discomfort")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 5
        
        question = Questions()
        
        question.question = "Anxiety/Depression"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("I am not anxious or depressed")
        answers.append("I am slightly anxious or depressed")
        answers.append("I am moderately anxious or depressed")
        answers.append("I am severely anxious or depressed")
        answers.append("I am extremely anxious or depressed")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 6
        
        question = Questions()
        
        question.question = "We would like to know how good or bad your health is TODAY. The slider is numbered from 0 to 100. 100 means the best health you can imagine, while 0 means the worst health you can imagine. Adjust the slider to indicate how your health is TODAY."
        question.type = "slider"
        
        q.questions.append(question)
        
        //APPEND QUESTIONNAIRE
        questionnaires.append(q)
        
        ///////////
        //       //
        //  LSA  //
        //       //
        ///////////
        
        q = Questionnaire()
        
        q.name = "LSA"
        
        //QUESTION 1 PART 1
        question = Questions()
        
        question.question = "During the past 4 weeks, have you been to other rooms of your home besides the room where you sleep?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("Yes")
        answers.append("No")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 1 PART 2
        question = Questions()
        
        question.question = "If yes - how many days within a week do you leave the room in which you sleep?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("1")
        answers.append("2")
        answers.append("3")
        answers.append("4")
        answers.append("5")
        answers.append("6")
        answers.append("7")
        answers.append("N/A")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 1 PART 3
        question = Questions()
        
        question.question = "Do you need help of an another person or an assistive device in order to do this?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes assistive device")
        answers.append("yes another person")
        answers.append("yes both")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 2 PART 1
        question = Questions()
        
        question.question = "During the past 4 weeks, have you been to an area outside your home such as your porch, deck or patio, hallway of an apartment building, or garage?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 2 PART 2
        question = Questions()
        
        question.question = "If yes - how many days within a week do go to an area outside of your home?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("1")
        answers.append("2")
        answers.append("3")
        answers.append("4")
        answers.append("5")
        answers.append("6")
        answers.append("7")
        answers.append("N/A")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 2 PART 3
        question = Questions()
        
        question.question = "Do you need help of an another person or an assistive device in order to do this?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes assistive device")
        answers.append("yes another person")
        answers.append("yes both")
        answers.append("no")

        //QUESTION 3 PART 1
        question = Questions()
        
        question.question = "During the past 4 weeks, have you been to places in your neighbourhood, other than your own yard or apartment building?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 3 PART 2
        question = Questions()
        
        question.question = "If yes - how many days within a week do go to places in your neighbourhood?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("1")
        answers.append("2")
        answers.append("3")
        answers.append("4")
        answers.append("5")
        answers.append("6")
        answers.append("7")
        answers.append("N/A")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 3 PART 3
        question = Questions()
        
        question.question = "Do you need help of an another person or an assistive device in order to do this?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes assistive device")
        answers.append("yes another person")
        answers.append("yes both")
        answers.append("no")

        //QUESTION 4 PART 1
        question = Questions()
        
        question.question = "During the past 4 weeks, have you been to places outside your neighbourhood but within your town?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 4 PART 2
        question = Questions()
        
        question.question = "If yes - how many days within a week do you go to places outside of your neighbourhood?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("1")
        answers.append("2")
        answers.append("3")
        answers.append("4")
        answers.append("5")
        answers.append("6")
        answers.append("7")
        answers.append("N/A")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 4 PART 3
        question = Questions()
        
        question.question = "Do you need help of an another person or an assistive device in order to do this?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes assistive device")
        answers.append("yes another person")
        answers.append("yes both")
        answers.append("no")
        
        //QUESTION 5 PART 1
        question = Questions()
        
        question.question = "During the past 4 weeks, have you been to places outside your town?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION PART 2
        question = Questions()
        
        question.question = "If yes - how many days within a week do you go to places outside of your town?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("1")
        answers.append("2")
        answers.append("3")
        answers.append("4")
        answers.append("5")
        answers.append("6")
        answers.append("7")
        answers.append("N/A")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 5 PART 3
        question = Questions()
        
        question.question = "Do you need help of an another person or an assistive device in order to do this?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes assistive device")
        answers.append("yes another person")
        answers.append("yes both")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 6
        question = Questions()
        
        question.question = "Do you consider neighbourhood to be less than 1km (5-6 city blocks)?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //QUESTION 7
        question = Questions()
        
        question.question = "Do you consider town to be less than 16 km?"
        question.type = "multiple_choice"
        
        answers = [String]()
        
        answers.append("yes")
        answers.append("no")
        
        question.answers.append(contentsOf: answers)
        
        q.questions.append(question)
        
        //APPEND QUESTIONNAIRE
        questionnaires.append(q)
    }
    
    ///////////////////////
    //                   //
    //  SETUP VARIABLES  //
    //                   //
    ///////////////////////
    
    var selectedQuestionnaire = Questionnaire()
    var questionSelected = false
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionnaires.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questionnaires[indexPath.row].name
        return cell
    }
    
    //when patient clicks on question, store the question name and index
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuestionnaire = questionnaires[indexPath.row]
        beginButton.isEnabled = true
        beginButton.alpha = 1;
    }
    
    ////////////////////////////////
    //                            //
    //  childView (HOLDS BUTTON)  //
    //                            //
    ////////////////////////////////
    
    let childView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40) //view size required, as the view holds the button.
        return view
    }()
    
    ////////////////////
    //                //
    //  BEGIN BUTTON  //
    //                //
    ////////////////////
    
    let beginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Begin", for: .normal)
        button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.frame = CGRect(x: UIScreen.main.bounds.width-80, y: 0, width: 60, height: 40)
        button.isEnabled = false
        button.alpha = 0.5;
        return button
    }()
    
    func setupBeginButton() {
        beginButton.addTarget(self, action: #selector(handleBegin), for: UIControlEvents.touchUpInside)
    }
    
    func handleBegin(Sender: UIButton!) {
        let questionnaireController2 = QuestionnaireController2()
        questionnaireController2.questionnaire = selectedQuestionnaire
        beginButton.isEnabled = false
        beginButton.alpha = 0.5;
        //change leftBarButtonItem of pushed view, as "Questionnaires" is too long.
        let backItem = UIBarButtonItem()
        backItem.title = "HRQoL"
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(questionnaireController2, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup questionnaires
        setupQuestionnaires()
        
        //setup table view
        navigationItem.title = "HRQoL"
        tableView.delaysContentTouches = false //this enables button animations, I don't know why.
        
        //register cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //setup "begin" button
        childView.addSubview(beginButton)
        setupBeginButton()
        
        //add child view to table view footer.
        tableView.tableFooterView = childView
    }
}
