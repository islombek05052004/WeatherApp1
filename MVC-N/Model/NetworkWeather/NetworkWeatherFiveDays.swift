//
//  NetworkWeatherFiveDays.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import UIKit

class NetworkWeatherFiveDays {
    
    private init() {}
    
    static let shared = NetworkWeatherFiveDays()
    private let apiKey = "56797753d5da99969b3f04af2ca3f5e1"

    public func getCurrentWeatherWith(cityName: String, completion: @escaping (WeatherDataFiveDays) -> ()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)") else { return }
        NetworkServise.shared.getDataWith(url: url) { JSONData in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                let weatherFiveDays = try decoder.decode(WeatherDataFiveDays.self, from: JSONData)
                DispatchQueue.main.async {
                    completion(weatherFiveDays)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

