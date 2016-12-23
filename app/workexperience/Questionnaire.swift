//
//  Questionnaire.swift
//  workexperience
//
//  Created by untitled on 1/12/16.
//  Copyright © 2016 untitled. All rights reserved.
//

import Foundation

class Questionnaire {
    var name: String?
    var questions = [Questions]()
}

class Questions {
    var type: String?
    var question: String?
    var answers = [String]()
}
