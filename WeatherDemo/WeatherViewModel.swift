//
//  WeatherViewModel.swift
//  WeatherDemo
//
//  Created by Marco Alonso Rodriguez on 15/06/23.
//

import Foundation
import UIKit

class WeatherViewModel {
    
    let webservice: Webservice
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }

    func getWeatherData(cityName: String, completion: @escaping (_ weatherObj: WeatherModel?, _ error: Error?) -> ()) {
        webservice.getWeatherData(cityName: cityName) { weatherData, error in
            if let weatherData = weatherData {
                completion(weatherData, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
}

extension UIImageView {
    func loadFrom(url: String) {
        guard let url = URL(string: url) else {
            print("Bad url image!")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, _, error in
            if let safeData = data {
                if let loadedImage = UIImage(data: safeData) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            }
        }
        task.resume()
    }
}
