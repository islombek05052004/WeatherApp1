//
//  WeatherFiveDays.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

struct WeatherFiveDays {
    
    let temperature: Double
    let time: String
    let id: Int
    
    var temperatureString: String {
        return "\(temperature.rounded() - 273)˚C"
    }
    var SystemIconNameString: String {
        
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
    
    init?(fiveDaysData: List) {

        self.time = fiveDaysData.dt_txt
        self.temperature = fiveDaysData.main.temp
        self.id = fiveDaysData.weather.first?.id ?? 800
    }
}
