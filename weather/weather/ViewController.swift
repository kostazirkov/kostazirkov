//
//  ViewController.swift
//  weather
//
//  Created by Гость on 20.06.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherimgview: UIImageView!
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    let locationManager = CLLocationManager()
    var weatherData = WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startLocationManager()
    }
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateView() {
        cityName.text = weatherData.name
        weatherDescription.text = DataSource.weatherIDs[weatherData.weather[0].id]
        temp.text = weatherData.main.temp.description + "°"
        weatherimgview.image = UIImage(named: weatherData.weather[0].icon)
    }

    func updateWeatherInfo(latitude: Double, longtitude: Double) {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&units=metric&lang=ru&appid=08ff133276b1e92dc949e588786e1894")!
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }
            
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
        }
    }
}

