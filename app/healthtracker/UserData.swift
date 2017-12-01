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
    var uniqueId: String
    var startTime: String
    var endTime: String
    var steps: String
    var distance: String?
}

struct LocationData: Encodable {
    var uniqueId: String
    var time: String
    var latitude: String
    var longitude: String
}

struct SurveyData: Encodable {
    var uniqueId: String
    var time: String
    var title: String
    var question: String
    var answer: String
}

struct HeightWeightData: Encodable {
    var uniqueId: String
    var time: String
    var height: String
    var weight: String
}

struct WalkTestData: Encodable {
    var uniqueId: String
    var time: String
    var steps: String
    var distance: String
    var laps: String
}
