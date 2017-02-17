//
//  Structs.swift
//  sendLocation
//
//  Created by untitled on 13/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import Foundation

//////////////
//          //
//  SURVEY  //
//          //
//////////////

struct Survey {
    var title: String
    var steps: [Step]
    
    init(title: String) {
        self.title = title
        steps = [Step]()
    }
}

struct Step {
    var title: String
    var type: String //instruction, text, multiple_choice, slider
    var subtitle: String?
    var isSkippable = false
    
    var instruction: Instruction?
    var multiple_choice: MultipleChoice?
    var scale: Scale?
    
    init(title: String, type: String) {
        self.title = title
        self.type = type
        
        if (type == "instruction") {
            instruction = Instruction()
        } else if (type == "multiple_choice") {
            multiple_choice = MultipleChoice()
        } else if (type == "scale") {
            scale = Scale()
        }
    }
}

struct Instruction {
    var content: String?
}

struct MultipleChoice {
    var answers: [String] = [String]()
}

struct Scale {
    var min_value = 0
    var max_value = 0
    var default_value = 0
    var step = 0
}

///////////////////
//               //
//  PERMISSIONS  //
//               //
///////////////////

struct PermissionPage {
    let heading: String
    let content: String
    let unicodeEscaped: String
}
