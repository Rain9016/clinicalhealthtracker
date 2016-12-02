//
//  QuestionnaireController2.swift
//  workexperience
//
//  Created by untitled on 30/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class QuestionnaireController2: UITableViewController {
    var questionnaire = Questionnaire()
    var questionnaireString: String?
    var questionnaireNumber: Int?
    var currentQuestion = 0
    var isAnswerSelected = false
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if questionnaire.questions[currentQuestion].answers.count > 0 {
            return questionnaire.questions[currentQuestion].answers.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if question type is "slider"
        if (questionnaire.questions[currentQuestion].type == "slider") {
            let cell: SliderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "sliderCell") as! SliderTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            //cell.userInteractionEnabled = false
            cell.add()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = questionnaire.questions[currentQuestion].answers[indexPath.row]
            cell.textLabel?.numberOfLines = 0;
            cell.textLabel?.lineBreakMode = .byWordWrapping
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (questionnaire.questions[currentQuestion].type == "slider") {
            return 100
        } else {
            return tableView.rowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let question = CustomLabel()
        question.backgroundColor = UIColor.lightGray
        question.text = questionnaire.questions[currentQuestion].question
        question.numberOfLines = 0
        question.lineBreakMode = .byWordWrapping
        
        return question
    }
    
    //when patient clicks on question, set answerSelected to true
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isAnswerSelected = true
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
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40) //need this to make button work.
        return view
    }()
    
    ///////////////////
    //               //
    //  NEXT BUTTON  //
    //               //
    ///////////////////
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        //button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.frame = CGRect(x: UIScreen.main.bounds.width-80, y: 0, width: 60, height: 40)
        return button
    }()
    
    func setupNextButton() {
        nextButton.addTarget(self, action: #selector(handleNext), for: UIControlEvents.touchUpInside)
    }
    
    func handleNext(Sender: UIButton!) {
        if (currentQuestion < questionnaire.questions.count - 1 && isAnswerSelected) {
            currentQuestion = currentQuestion + 1
            isAnswerSelected = !isAnswerSelected
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Questions"
        tableView.estimatedRowHeight = 1000 //must be provided for tableView.rowHeight to work. 100 is an arbitrary value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 1000
        
        //disable scrolling when content height is less than page height.
        tableView.alwaysBounceVertical = false
        
        //this enables button animations, I don't know why.
        tableView.delaysContentTouches = false
        
        //register table cell for reuse?
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "textFieldCell")
        self.tableView.register(SliderTableViewCell.self, forCellReuseIdentifier: "sliderCell")
        
        //set up begin button.
        childView.addSubview(nextButton)
        setupNextButton()
        
        //add childView to tableView footer.
        tableView.tableFooterView = childView
    }
}

class CustomLabel: UILabel {
    
    var topInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var leftInset: CGFloat = 12
    var rightInset: CGFloat = 12
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
