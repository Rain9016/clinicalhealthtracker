//
//  QuestionnaireQuestionsController.swift
//  app
//
//  Created by untitled on 29/11/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class QuestionnaireController1: UITableViewController {
    let questions = ["question 1", "question 2", "question 3", "question 4"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(questions[indexPath.row])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Questionnaires"
        
        //register table cell for reuse?
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
