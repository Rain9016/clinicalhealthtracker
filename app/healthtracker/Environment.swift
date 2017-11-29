//
//  Environment.swift
//  healthtracker
//
//  Created by chris on 29/11/17.
//
import Foundation

class Environment {
    static let shared = Environment()
    
    private init() {}
    
    let development = Development()
    let production = Production()
}

class Development {
    let url = "http://192.168.0.3:8888/api/"
}

class Production {
    let url = "https://www.clinicalhealthtracker.com/api/"
}
