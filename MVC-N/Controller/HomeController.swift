//
//  HomeController.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 15/09/23.
//

import UIKit

class HomeController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=London&appid=56797753d5da99969b3f04af2ca3f5e1") else { return }
        let session = URLSession.shared
        
        
        session.dataTask(with: url) { data, response, error in
            
//            guard response is HTTPURLResponse else { return }
            
            if let error = error {
                
                print(error.localizedDescription)
                return
                
            }
            
            if data != nil {
                self.getWeatherDataFiveDays(With: data!) { WeatherDataFiveDays in
                    print(WeatherDataFiveDays)
                }
            }
        }.resume()
    }
    
    
    func getWeatherDataFiveDays(With data: Data, completion: @escaping (WeatherDataFiveDays) -> ()) {
        
        do {
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let weatherDataFiveDays = try decoder.decode(WeatherDataFiveDays.self, from: data)
            completion(weatherDataFiveDays)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
}





