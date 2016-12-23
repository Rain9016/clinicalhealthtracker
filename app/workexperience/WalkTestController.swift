//
//  WalkTestController.swift
//  workexperience
//
//  Created by untitled on 1/12/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class WalkTestController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TextFieldTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "textInputCell") as! TextFieldTableViewCell
        
        cell.configure(text: "", placeholder: "Enter some text!")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog."
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
        let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.viewWithTag(1) as! UITextField
        let result = text.text
        print (result! as String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Questions"
        
        //this enables button animations, I don't know why.
        tableView.delaysContentTouches = false

        //register table cell for reuse?
        self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "textInputCell")
        
        //set up begin button.
        childView.addSubview(nextButton)
        setupNextButton()
        
        //add childView to tableView footer.
        tableView.tableFooterView = childView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
