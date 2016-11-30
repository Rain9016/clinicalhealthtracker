//
//  QuestionnaireController1.swift
//  workexperience
//
//  Created by untitled on 30/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class QuestionnaireController1: UITableViewController {
    let questions = ["question 1", "question 2", "question 3", "question 4"]
    
    /////////////
    //         //
    //  SETUP  //
    //         //
    /////////////
    
    var questionString: String?
    var questionNumber: Int?
    var questionSelected = false
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
    
    //when patient clicks on question, store the question name and index
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questionString = questions[indexPath.row]
        questionNumber = questions.index(of: questions[indexPath.row])
        questionSelected = true
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
    
    ////////////////////
    //                //
    //  BEGIN BUTTON  //
    //                //
    ////////////////////
    
    let beginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Begin", for: .normal)
        //button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.frame = CGRect(x: UIScreen.main.bounds.width-80, y: 0, width: 60, height: 40)
        return button
    }()
    
    func setupBeginButton() {
        beginButton.addTarget(self, action: #selector(handleBegin), for: UIControlEvents.touchUpInside)
    }
    
    func handleBegin(Sender: UIButton!) {
        if (questionSelected != false) {
            let questionnaireController2 = QuestionnaireController2()
            questionnaireController2.questionnaireString = questionString
            questionnaireController2.questionnaireNumber = questionNumber
            questionnaireController2.questionnaireNumber = 0
            questionSelected = false
            self.navigationController?.pushViewController(questionnaireController2, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Questionnaires"
        
        //this enables button animations, I don't know why.
        tableView.delaysContentTouches = false
        
        //register table cell for reuse?
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //set up begin button.
        childView.addSubview(beginButton)
        setupBeginButton()
        
        //add childView to tableView footer.
        tableView.tableFooterView = childView
    }
}
