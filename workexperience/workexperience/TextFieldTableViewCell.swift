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
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
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
