//
//  SixMinuteWalkTestController.swift
//  workexperience
//
//  Created by untitled on 5/12/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class SixMinuteWalkTestController: UIViewController {
    var timeRemaining = 0
    var timer = Timer()
    var timerTwo = Timer()
    
    var timeRemainingLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 90)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupTimeRemainingLabel() {
        timeRemainingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeRemainingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
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
        startButton.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 20).isActive = true
        
        startButton.addTarget(self, action: #selector(handleStart), for: UIControlEvents.touchUpInside)
    }
    
    func handleStart() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        startButton.isEnabled = false
        startButton.alpha = 0.5
        stopButton.isEnabled = true
        stopButton.alpha = 1
    }
    
    func countdown() {
        timeRemaining = timeRemaining - 1
        let (m, s) = secondsToMinutesSeconds(seconds: timeRemaining)
        timeRemainingLabel.text = "\(timeText(m)):\(timeText(s))"
        
        if (timeRemaining == 0) {
            timer.invalidate()
        }
    }
    
    var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        //button.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    func setupStopButton() {
        stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10).isActive = true
        
        stopButton.addTarget(self, action: #selector(handleStop), for: UIControlEvents.touchUpInside)
    }
    
    func handleStop() {
        timer.invalidate()
        reset()
        
        startButton.isEnabled = true
        startButton.alpha = 1
    }
    
    func reset() {
        timeRemaining = 30
        let (m, s) = secondsToMinutesSeconds(seconds: timeRemaining)
        timeRemainingLabel.text = "\(timeText(m)):\(timeText(s))"
        
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
    }
    
    //////////////////////////////////////
    //                                  //
    //  SECONDS TO MINUTES AND SECONDS  //
    //                                  //
    //////////////////////////////////////
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func timeText(_ s: Int) -> String {
        return s < 10 ? "0\(s)" : "\(s)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialise timer (seconds)
        reset()
        
        //setup table view
        navigationItem.title = "6MWT"
        //view.delaysContentTouches = false //this enables button animations, I don't know why.
        
        view.backgroundColor = UIColor.white
        
        //setup views
        view.addSubview(timeRemainingLabel)
        setupTimeRemainingLabel()
        view.addSubview(startButton)
        setupStartButton()
        view.addSubview(stopButton)
        setupStopButton()
    }
}
