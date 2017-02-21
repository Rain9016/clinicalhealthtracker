//
//  WalkTestInstructionController.swift
//  healthtracker
//
//  Created by untitled on 15/2/17.
//
//

import UIKit

class WalkTestInstructionController: UIViewController {
    var page: Int!
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

    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    func buttonAction() {
        guard (page != 1) else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        /* set the back bar button item */
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "Back"
        navigationItem.backBarButtonItem = backBarButtonItem
        
        let instructionController = WalkTestInstructionController()
        instructionController.page = self.page + 1
        self.navigationController?.pushViewController(instructionController, animated: true)
    }
    
    let cancel_button: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Close"
        barButtonItem.style = .done
        barButtonItem.action = #selector(cancelButtonAction)
        return barButtonItem
    }()
    
    func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func playNext() {
        if (page == 0) {
            if !audioManager.isPlaying() {
                audioManager.playAudio(name: "instruction-p1-pt2")
                
                if (timer.isValid) {
                    timer.invalidate()
                }
            }
        } else if (page == 1) {
            if !audioManager.isPlaying() {
                audioManager.playAudio(name: "instruction-p2-pt2")
                
                if (timer.isValid) {
                    timer.invalidate()
                }
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
        contentView.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        switch page {
        case 0:
            label.text = "The object of this test, is to walk as far as possible for six minutes. You will walk back and forth. Six minutes is a long time to walk, so you will be exerting yourself. You may get out of breath, or find it exhausting. You should walk and not run, at your own pace. You can slow down, stop, and rest as you need to. You may lean against the wall, or sit down while resting.\n\nYou should perform the test on a level, flat surface. You will need to set a start point and a point around which you will walk. You should try to make this distance as close to 30 meters as possible. You should perform the test in someone else’s presence, so they can call for assistance if required."
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
            button.setTitle("Next", for: .normal)
        case 1:
            label.text = "You must not complete this test if you have had a heart attack or suffered angina in the last month.\n\nIf you develop chest pain, intolerable breathlessness, leg cramps, if you start staggering, severely sweating or someone says you look unwell, you must stop the test immediately."
            
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
        default:
            return
        }
        
        let padding_bottom = UIView()
        contentView.addSubview(padding_bottom)
        padding_bottom.translatesAutoresizingMaskIntoConstraints = false
        switch page {
        case 0:
            padding_bottom.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25).isActive = true
        case 1:
            padding_bottom.topAnchor.constraint(equalTo: second_label.bottomAnchor, constant: 25).isActive = true
        default:
            return
        }
        padding_bottom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    /////////////////////////////////////
    //                                 //
    //  WHEN PAGE APPEARS, PLAY AUDIO  //
    //                                 //
    /////////////////////////////////////
    override func viewDidAppear(_ animated: Bool) {
        switch page {
        case 0:
            audioManager.playAudio(name: "instruction-p1-pt1")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playNext), userInfo: nil, repeats: true)
        case 1:
            audioManager.playAudio(name: "instruction-p2-pt1")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playNext), userInfo: nil, repeats: true)
        default:
            return
        }
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
