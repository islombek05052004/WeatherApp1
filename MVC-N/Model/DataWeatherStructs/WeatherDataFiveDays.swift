//
//  WeatherFiveDaysData.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import Foundation


struct WeatherDataFiveDays: Codable {
    
    let list: [List]
}

struct List: Codable {
    
    let dt_txt: String
    let main: FiveDaysMain
    let weather: [FiveDaysWeather]
}

struct FiveDaysMain: Codable {
    let temp: Double
}

struct FiveDaysWeather: Codable {
    let id: Int
}

extension List {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decode(FiveDaysMain.self, forKey: .main)
        dt_txt = try values.decode(String.self, forKey: .dt_txt)
        weather = try values.decode([FiveDaysWeather].self, forKey: .weather)
    }
}

