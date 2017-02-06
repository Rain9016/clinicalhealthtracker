//
//  Structs.swift
//  sendLocation
//
//  Created by untitled on 13/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import Foundation

struct Questionnaire {
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
    var isSkippable: Bool?
    
    var instruction_text: String?
    
    var multiple_choice_answers: [String]?
    
    var scale_min_value: Int?
    var scale_max_value: Int?
    var scale_default_value: Int?
    var scale_step: Int?
    
    init(title: String, type: String) {
        self.title = title
        self.type = type
        self.isSkippable = false
        
        if (type == "multiple_choice") {
            self.multiple_choice_answers = [String]()
        }
    }
}

struct PermissionPage {
    let heading: String
    let content: String
    let unicodeEscaped: String
}
