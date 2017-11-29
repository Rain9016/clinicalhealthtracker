//
//  DataToSend.swift
//  healthtracker
//
//  Created by untitled on 9/2/17.
//
//

import Foundation

class UserData {
    static let shared = UserData()
    
    private init() {}
    
    var healthData = [HealthData]()
    var locationData = [LocationData]()
    var surveyData = [SurveyData]()
    var heightWeightData = [HeightWeightData]()
    var walkTestData = [WalkTestData]()
}

struct ApiResponse: Decodable {
    var error: Bool
    var message: String
}

struct HealthData: Encodable {
    
}

struct LocationData: Encodable {
    
}

struct SurveyData: Encodable {
    
}

struct HeightWeightData: Encodable {
    
}

struct WalkTestData: Encodable {
    
}
