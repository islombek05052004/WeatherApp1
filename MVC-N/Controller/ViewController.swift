//
//  ViewController.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: Labels
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // MARK: UIimageView
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    // MARK: UIbutton
    @IBOutlet weak var searchButton: UIButton!

    
    private var WeatherfiveDays = [List]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataWeather(With: "London")
    }
    
    // MARK: UIButtonAction
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        alertAction(title: "Entering city name", message: "city name for weather") { cityName in
            self.getDataWeather(With: cityName)
        }
    }
    
    private func getDataWeather(With cityName: String ) {
        NetworkCurrentWeather.shared.getCurrentWeatherWith(cityName: cityName) { CurrentWeather in
            self.upDateInterface(CurrentWeather)
        }
        NetworkWeatherFiveDays.shared.getCurrentWeatherWith(cityName: cityName) { WeatherDataFiveDays in
            DispatchQueue.main.async {
                self.WeatherfiveDays = WeatherDataFiveDays.list
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: UpDateInterface & alertVC

extension ViewController {
    
    private func upDateInterface(_ currentWeather: CurrentWeather?) {
        
        if let currentWeather = currentWeather {
            DispatchQueue.main.async { [weak self] in
                self?.cityNameLabel.text = currentWeather.name
                self?.weatherIconImage.image = UIImage(named: currentWeather.systemIconNameString)
                self?.feelsLikeLabel.text = "Feels like: \(currentWeather.feelsLikeTemperaturaString)"
                self?.temperatureLabel.text = currentWeather.temperatureString
                self?.windSpeedLabel.text = "\(currentWeather.speed)"
            }
        }
    }
    
    private func alertAction(title: String, message: String, completionHandler: @escaping (String) -> ()) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addTextField()
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { search in
            let tf = alertVC.textFields?.first
            guard let cityName = tf?.text else {return}
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(searchAction)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}

// MARK: CollectionVIewDelegates

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherfiveDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if let objc = WeatherFiveDays(fiveDaysData: WeatherfiveDays[indexPath.row]) {
            cell.setUpData(list: objc)
            cell.layer.cornerRadius = 20
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.bounds.size.height
        return CGSize(width: collectionViewHeight * 0.675 , height: collectionViewHeight * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
}

