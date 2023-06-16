//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Marco Alonso Rodriguez on 15/06/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var namePlaceLabel: UILabel!
    @IBOutlet weak var confitionLabel: UILabel!
    @IBOutlet weak var cityNameSearch: UITextField!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var locationTimeLabel: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    let viewModel = WeatherViewModel(webservice: Webservice.shared)
    
    var weatherData: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameSearch.delegate = self
        
        getWeatherData(city: "London")
    }
    
    private func getWeatherData(city: String){
        viewModel.getWeatherData(cityName: city) { weatherObj, error in
            if let weatherObj = weatherObj {
                
                DispatchQueue.main.async {
                    self.weatherData = weatherObj
                    self.namePlaceLabel.text = weatherObj.location.name
                    self.locationTimeLabel.text = "Local time: \(weatherObj.location.localtime)"
                    self.confitionLabel.text = "Condition: \(weatherObj.current.condition.text)"
                    
                    let url = weatherObj.current.condition.icon
                    let cleanURL = String(url.dropFirst(2))
                    
                    print("Debug: cleanURL \(cleanURL)")

                    self.imageWeather.loadFrom(url: "https://\(cleanURL)")
                    self.temperature.text = "\(weatherObj.current.temp_c)°C"
                    self.lastUpdated.text = "last updated: \(weatherObj.current.last_updated)"
                }
            }
        }
    }

    @IBAction func degresOption(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //Celcius
            self.temperature.text = "\(weatherData?.current.temp_c ?? 0)°C"
            
        case 1:
            //Farenheit
            temperature.text = "\(weatherData?.current.temp_f ?? 0)°F"
        default:
            //Celcius
            print("Default")
        }
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //ocultar teclado
        textField.endEditing(true)
        return true
    }
    
    //2.- Identificar cuando el usuario termina de editar y que pueda borrar el contenido del textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Hacer algo
        if textField.text != "" {
            getWeatherData(city: textField.text!)
        }
        
        textField.text = ""
        textField.endEditing(true)
    }
    
    //3.- Evitar que el usuario no escriba nada
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            //el usuario no escribio nada
            textField.placeholder = "Debes escribir algo.."
            return false
        }
    }
}

