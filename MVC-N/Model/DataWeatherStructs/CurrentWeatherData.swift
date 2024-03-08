//
//  CurrentWeather.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import Foundation


struct CurrentWeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    
    let temp: Double
    let fellsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case fellsLike = "feels_like"
    }
}
struct Weather: Codable {
    
    let id: Int
}

struct Wind: Codable {
    
    let speed: Double
    
}
