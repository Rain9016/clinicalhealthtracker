//
//  TextFieldTableViewCell.swift
//  workexperience
//
//  Created by untitled on 1/12/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    public func configure(text: String?, placeholder: String) {
        let textField = UITextField()
        
        textField.layer.borderWidth = 1
        
        textField.text = text
        textField.placeholder = placeholder
        //textField.accessibilityValue = text
        //textField.accessibilityLabel = placeholder
        textField.tag = 1
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        
        //need x, y, width, height contraints
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -12).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SliderTableViewCell: UITableViewCell {
    let myLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Health rating: 50"
        lbl.sizeToFit()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let mySlider: UISlider = {
        let slider = UISlider()
        slider.tag = 1
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        //slider.tintColor = UIColor.red
        slider.value = 50
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    public func add() {
        self.addSubview(myLabel)
        
        myLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true

        self.addSubview(mySlider)
        
        mySlider.addTarget(self, action: #selector(handleSlider), for: UIControlEvents.touchUpInside)
        
        //need x, y, width, height contraints
        mySlider.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mySlider.centerYAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20).isActive = true
        mySlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
    }
    
    func handleSlider(sender: UISlider) {
        myLabel.text = "Health rating: " + String(Int(sender.value))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
