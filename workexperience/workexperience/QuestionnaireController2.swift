//
//  QuestionnaireController2.swift
//  workexperience
//
//  Created by untitled on 30/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class QuestionnaireController2: UITableViewController {
    
    var questionnaireString: String?
    var questionnaireNumber: Int?
    var questionnaires = [String: [[String]]]()
    var questionNumber = 0
    var answerSelected = false
    
    let answers = [["answer 1", "answer 2", "answer 3"], ["answer 4", "answer 5", "answer 6"], ["answer 7", "answer 8", "answer 9"], ["answer 10", "answer 11", "answer 12"]]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers[questionnaireNumber!].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questionnaires[questionnaireString!]?[questionNumber][indexPath.row]
        return cell
    }
    
    //when patient clicks on question, set answerSelected to true
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answerSelected = true
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
        button.setTitle("Next", for: .normal)
        //button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.frame = CGRect(x: UIScreen.main.bounds.width-80, y: 0, width: 60, height: 40)
        return button
    }()
    
    func setupBeginButton() {
        beginButton.addTarget(self, action: #selector(handleBegin), for: UIControlEvents.touchUpInside)
    }
    
    func handleBegin(Sender: UIButton!) {
        if (questionNumber < (questionnaires[questionnaireString!]?.count)!-1 && answerSelected) {
            questionNumber = questionNumber + 1
            answerSelected = !answerSelected
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionnaires[questionnaireString!] = [["answer 1", "answer 2", "answer 3"], ["answer 4", "answer 5", "answer 6"], ["answer 7", "answer 8", "answer 9"], ["answer 10", "answer 11", "answer 12"]]
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Questions"
        
        //this enables button animations, I don't know why.
        tableView.delaysContentTouches = false
        
        //register table cell for reuse?
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //set up begin button.
        childView.addSubview(beginButton)
        setupBeginButton()
        
        //add childView to tableView footer.
        tableView.tableFooterView = childView
        
        print(questionnaireString!)
        print(questionnaireNumber!)
    }
}
