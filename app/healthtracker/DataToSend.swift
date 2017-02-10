//
//  DataToSend.swift
//  healthtracker
//
//  Created by untitled on 9/2/17.
//
//

import Foundation

class DataToSend: NSObject {
    static let sharedInstance: DataToSend = {
        let instance = DataToSend()
        return instance
    }()
    
    var hk_data = [String:[[String:String]]]()
    var location_data = [String:[[String:String]]]()
    var questionnaire_data = [String:[[String:String]]]()
    var walk_test_data = [String:[[String:String]]]()
    
    override init() {
        super.init()
        
        hk_data = ["hk_data":[]]
        location_data = ["location_data":[]]
        questionnaire_data = ["questionnaire_data":[]]
        walk_test_data = ["walk_test_data":[]]
    }
}
