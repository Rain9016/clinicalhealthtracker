//
//  SixMinuteWalkTestController.swift
//  workexperience
//
//  Created by untitled on 5/12/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class SixMinuteWalkTestController: UIViewController {
    var timeRemaining: UILabel = {
        let label = UILabel()
        label.text = "06:00"
        label.font = UIFont.systemFont(ofSize: 90)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupTimeRemaining() {
        timeRemaining.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeRemaining.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        //timeRemaining.widthAnchor.constraint(equalToConstant: 30).isActive = true
        //timeRemaining.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        //button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupStartButton() {
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.topAnchor.constraint(equalTo: timeRemaining.bottomAnchor, constant: 20).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 200)
        startButton.heightAnchor.constraint(equalToConstant: 200)
    }
    
    var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        //button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    func setupStopButton() {
        stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10).isActive = true
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
        
        //let (h, m, s) = secondsToHoursMinutesSeconds (seconds)
        //print ("\(h) Hours, \(m) Minutes, \(s) Seconds")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup table view
        navigationItem.title = "6MWT"
        //view.delaysContentTouches = false //this enables button animations, I don't know why.
        
        view.backgroundColor = UIColor.white
        
        //setup views
        view.addSubview(timeRemaining)
        setupTimeRemaining()
        view.addSubview(startButton)
        setupStartButton()
        view.addSubview(stopButton)
        setupStopButton()
    }
}
