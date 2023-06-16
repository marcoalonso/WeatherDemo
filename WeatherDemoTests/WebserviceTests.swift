//
//  WebserviceTests.swift
//  WeatherDemoTests
//
//  Created by Marco Alonso Rodriguez on 16/06/23.
//

import XCTest
@testable import WeatherDemo

class WebserviceTests: XCTestCase {

    var sut: Webservice!
    
    override func setUp() {
        super.setUp()
        sut = Webservice()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testWebserviceGetData(){
        let exp = expectation(description: "Getting Model")
        var model: WeatherModel?
        
        sut.getWeatherData(cityName: "morelia") { weatherData, error in
            if let modelData = weatherData {
                model = modelData
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.location.name, "Morelia")
    }

}
