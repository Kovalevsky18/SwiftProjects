//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Родион Ковалевский on 3/12/19.
//  Copyright © 2019 Родион Ковалевский. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    let today = NSDate()
    var locationManager = CLLocationManager()
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                getJSONSearch { [weak self] result , error in
            
            DispatchQueue.main.async {
                self?.nameLabel.text = result?.name
                self?.tempLabel.text = String(Int((result?.main.temp)!)-273)
            }
            
        }
    }

//    func getday(){
//        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))!
//        dayOutlet.text = String(Calendar.current.component(.weekday, from: Date()))
//    }
    func getLocation(){
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest// для большей точности
        locationManager.requestWhenInUseAuthorization()//автозапрос юзеру на использование его координат
        locationManager.startUpdatingLocation()
    }
    @IBAction func getMyLocationButton(_ sender: Any) {
        getLocation()

    }
    func getJSONSearch(complition: @escaping (_ result : CurrentWeather?, _ error: Error?)->()) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Minsk,by&APPID=a632e471f0b9c0c8bb09710584a6c1cc") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        print(json)
                        let jsonWeather =  CurrentWeather()
                        if let main = json["main"] as? [String : Any] {
                            if let temp = main["temp"] as? Double {
                                jsonWeather.main.temp = temp
                            }
                        }
                        if let name = json["name"] as? String {
                            jsonWeather.name = name
                            
                        }
//                        if let weather = json["weather"] as? [String:Any]{
//                            if let main = weather["main"] as? String{
//                                jsonWeather.weather.main = weather
//                            }
//                        }
                        
                        complition(jsonWeather, nil)
                    }
                }catch{
                    print(error)
                    complition(nil, error)
                }
            }
        }
        task.resume() // прекратить выполнение
    }
}
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let coordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        self.locationOutlet.text = "широта:\(coordinates.latitude), долгота:\(coordinates.longitude)"
    }

    
}
