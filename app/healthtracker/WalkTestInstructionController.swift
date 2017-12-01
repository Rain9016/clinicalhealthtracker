//
//  WalkTestInstructionController.swift
//  healthtracker
//
//  Created by untitled on 15/2/17.
//
//

import UIKit

class WalkTestInstructionController: UIViewController {
    var audioManager = AudioManager.sharedInstance
    var timer = Timer()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    let second_label_heading: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let second_label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    let cancel_button: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Close"
        barButtonItem.style = .done
        barButtonItem.action = #selector(cancelButtonAction)
        return barButtonItem
    }()
    
    @objc func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func playNext() {
        if !audioManager.isPlaying() {
            audioManager.playAudio(name: "instruction-pt2")
                
            if (timer.isValid) {
                timer.invalidate()
            }
        }
    }
    
    func stop() {
        if (audioManager.isPlaying()) {
            audioManager.stopAudio()
        }
        
        if (timer.isValid) {
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Instructions"
        self.navigationController?.navigationBar.tintColor = UIColor.init(r: 204, g: 0, b: 0)
        cancel_button.target = self
        self.navigationItem.rightBarButtonItem = cancel_button
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true /* attach the top of the scrollview to below the navigation bar */
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true /* attach the bottom of the scrollview to above the tab bar */
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        label.text = "Before we begin the test you should place two markers as close to 30 meters apart as possible. You should perform the test on a hard, flat surface. You should perform the test in someone else’s presence so they can assist you if needed.\n\nThe aim of this test is to walk as far as possible for 6 minutes. You will walk between the two markers you have set, as many times as you can. I will let you know as each minute goes past, and then at 6 minutes I will ask you to stop where you are. 6 minutes is a long time to walk, so you will be exerting yourself. You are permitted to slow down, to stop, and to rest as necessary, but please resume walking as soon as you are able. Remember that the objective is to walk as far as possible for 6 minutes, but don’t run or jog."
        
        second_label_heading.text = "Before you begin.."
            
        second_label.text = "Press the \"Close\" button in the top right-hand corner of the screen to close the instructions and return to the main page. From there you will be able to begin the walk test. Upon pressing the \"Begin\" button, you will be told to stand still, face the direction you will be walking, place your phone in your pocket or in your hand by your side, and a countdown will commence. When the countdown finishes and you hear the word go, start walking."
            
        contentView.addSubview(second_label_heading)
        contentView.addSubview(second_label)
            
        second_label_heading.translatesAutoresizingMaskIntoConstraints = false
        second_label_heading.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        second_label_heading.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        second_label_heading.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            
        second_label.translatesAutoresizingMaskIntoConstraints = false
        second_label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        second_label.topAnchor.constraint(equalTo: second_label_heading.bottomAnchor, constant: 20).isActive = true
        second_label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let padding_bottom = UIView()
        contentView.addSubview(padding_bottom)
        padding_bottom.translatesAutoresizingMaskIntoConstraints = false
        padding_bottom.topAnchor.constraint(equalTo: second_label.bottomAnchor, constant: 25).isActive = true
        padding_bottom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    /////////////////////////////////////
    //                                 //
    //  WHEN PAGE APPEARS, PLAY AUDIO  //
    //                                 //
    /////////////////////////////////////
    override func viewDidAppear(_ animated: Bool) {
        audioManager.playAudio(name: "instruction-pt1")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playNext), userInfo: nil, repeats: true)
    }
    
    //////////////////////////////////////////////////
    //                                              //
    //  WHEN VIEW DISSAPEARS, STOP AUDIO AND TIMER  //
    //                                              //
    //////////////////////////////////////////////////
    override func viewWillDisappear(_ animated: Bool) {
        stop()
    }
}
