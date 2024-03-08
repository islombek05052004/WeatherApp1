//
//  NetworkServiseCurrentWeather.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import UIKit
import CoreLocation

class NetworkCurrentWeather {
    
    private init() {}
    
    static let shared = NetworkCurrentWeather()
    private let apiKey = "56797753d5da99969b3f04af2ca3f5e1"
    private func getCurrentWeatherWith(location: CLLocation, completion: @escaping (CurrentWeather) -> ()) {
        
        let latitute = location.coordinate.latitude
        let longitute = location.coordinate.longitude
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitute)&lon=\(longitute)&appid=\(apiKey)") else { return }
        
        NetworkServise.shared.getDataWith(url: url) { JSONData in
            
            let decoder = JSONDecoder()
            do {
                let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: JSONData)
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return } 
                completion(currentWeather)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    public func getCurrentWeatherWith(cityName: String, completion: @escaping (CurrentWeather) -> ()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)") else { return }
        
        NetworkServise.shared.getDataWith(url: url) { JSONData in
            
            let decoder = JSONDecoder()
            
            do {
                let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: JSONData)
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {return}
                completion(currentWeather)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
