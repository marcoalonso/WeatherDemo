//
//  WeatherDemoTests.swift
//  WeatherDemoTests
//
//  Created by Marco Alonso Rodriguez on 16/06/23.
//

import XCTest
@testable import WeatherDemo

 class WeatherDemoTests: XCTestCase {
     
     var sut: WeatherViewModel!
     

     override func setUp() {
         super.setUp()
         sut = WeatherViewModel(webservice: Webservice.shared)
     }
     
     override func tearDown() {
         super.tearDown()
         sut = nil
     }

     func testGettingDataFromViewModel(){
         let expectation = expectation(description: "Getting data from vm")
         var response = false
         
         sut.getWeatherData(cityName: "morelia") { weatherObj, error in
             if let data = weatherObj {
                 response = true
                 expectation.fulfill()
             }
         }
         wait(for: [expectation], timeout: 5)
         XCTAssertTrue(response)
     }
     
    

}
