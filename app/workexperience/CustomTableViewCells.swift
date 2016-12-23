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
    var title: String = "Slider value: "
    
    let myLabel: UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let mySlider: UISlider = {
        let slider = UISlider()
        slider.tag = 2
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    public func add(title: String, minValue: Int, maxValue: Int) {
        mySlider.minimumValue = Float(minValue)
        mySlider.maximumValue = Float(maxValue)
        mySlider.value = Float((minValue+maxValue)/2)
        
        self.title = title
        myLabel.text = self.title + String(Int(mySlider.value))
        
        self.addSubview(myLabel)
        
        myLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true

        self.addSubview(mySlider)
        
        mySlider.addTarget(self, action: #selector(handleSlider), for: UIControlEvents.valueChanged)
        
        //need x, y, width, height contraints
        mySlider.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mySlider.centerYAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20).isActive = true
        mySlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
    }
    
    func handleSlider(sender: UISlider) {
        myLabel.text = title + String(Int(mySlider.value))
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
