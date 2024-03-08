//
//  CurrentWeather.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import Foundation

struct CurrentWeather {
    
    let name: String
    let speed: Double
    
    let temperature: Double
    var temperatureString: String {
        return "\(Int(temperature.rounded()) - 273)˚C"
    }
    
    let feelsLikeTemperatura: Double
    var feelsLikeTemperaturaString: String {
        return "\(Int(feelsLikeTemperatura.rounded()) - 273)˚C"
    }
    
    let id: Int
    
    var systemIconNameString: String {
        
        switch id {
        case 200...232: return "storm"
        case 300...321: return "rain"
        case 500...531: return "cloudy"
        case 600...622: return "snow"
        case 700...781: return "wind"
        case 800: return "sun"
        case 801...804: return "sunfog"
        default: return "null"
        }
        
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        
        name = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperatura = currentWeatherData.main.fellsLike
        id = currentWeatherData.weather.first!.id
        speed = currentWeatherData.wind.speed
        
    }
    
}
