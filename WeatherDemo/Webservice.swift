//
//  Webservice.swift
//  WeatherDemo
//
//  Created by Marco Alonso Rodriguez on 15/06/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badURL
}

public class Webservice {
    public static let shared = Webservice()
    
    init() {}
    
    func getWeatherData(cityName: String, completionHandler: @escaping (_ weatherData: WeatherModel?, _ error: Error?) -> ()) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=9745357b64764a1c926173930223105&q=\(cityName)&aqi=no"
        
        guard let url = URL(string: urlString) else {
            print("Debug: Error bad url \(NetworkError.badURL)")

            completionHandler(nil, NetworkError.badURL)
            return
        }
        
        print("Debug: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, respuesta, error in
            
            if error != nil {
                completionHandler(nil, NetworkError.badRequest)
            }
            
            if let safeData = data {
                if let weatherData = self.parseJSON(weatherData: safeData) {
                 completionHandler(weatherData, nil)
                }
            } else {
                completionHandler(nil, NetworkError.decodingError)
            }
        }.resume()
        
    }

    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
            print(decodedData)
            return decodedData
        } catch {
            print("Error al decodificar \(error.localizedDescription)")
            return nil
        }
    }
}
