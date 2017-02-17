//
//  QuestionnaireCompleteController.swift
//  healthtracker
//
//  Created by untitled on 13/2/17.
//
//

import UIKit

class ActivityCompleteController: UIViewController {
    var activity: String!
    let data_to_send = DataToSend.sharedInstance
    
    let title_label: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        return label
    }()
    
    let content_label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    func doneButtonAction() {
        /* if conclusion audio from walk test is playing */
        let audioManager = AudioManager.sharedInstance
        if (audioManager.isPlaying()) {
            audioManager.stopAudio()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.hidesBackButton = true
        let done_button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        self.navigationItem.rightBarButtonItem = done_button
        
        view.addSubview(title_label)
        view.addSubview(content_label)
        
        content_label.translatesAutoresizingMaskIntoConstraints = false
        content_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        content_label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        content_label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        title_label.translatesAutoresizingMaskIntoConstraints = false
        title_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        title_label.bottomAnchor.constraint(equalTo: content_label.topAnchor, constant: -20).isActive = true
        
        let label = UILabel()
        label.font = UIFont.init(name: "Ionicons", size: 100)
        label.textColor = UIColor(r: 204, g: 0, b: 0)
        label.text = "\u{f120}"
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        let image = UIImage.imageWithLabel(label: label)
        let imageView = UIImageView(image: image)
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: content_label.bottomAnchor, constant: 20).isActive = true
        
        switch activity {
        case "survey":
            title_label.text = "Questionnaire Complete"
            content_label.text = "Your answers will be recorded and analysed by your clinician."
            
            send_data(type: "survey")
        case "walk_test":
            title_label.text = "Walk Test Complete"
            content_label.text = "Your results will be recorded and analysed by your clinician."
        default:
            return
        }
    }
}
