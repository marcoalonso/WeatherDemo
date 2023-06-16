//
//  WeatherModel.swift
//  WeatherDemo
//
//  Created by Marco Alonso Rodriguez on 15/06/23.
//

import Foundation

// MARK: - Welcome
struct WeatherModel: Codable {
    let location: Location
    let current: Current
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let localtime: String
}

// MARK: - Current
struct Current: Codable {
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}



