//
//  LufthansaAPIClient.swift
//  LufthansaMP4Skeleton
//
//  Created by Max Miranda on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LufthansaAPIClient {
    //These are where we will store all of the authentication information. Get these from your account at developer.lufthansa.com.
    static let clientSecret = "Nf8Faevzj5" //FIXME
    static let clientID = "kghujgcku7qekvq472jb786v" //FIXME
    
    //This variable will store the session's auth token that we will get from getAuthToken()
    static var authToken: String?
    
    //This function will request an auth token from the lufthansa servers
    static func getAuthToken(completion: @escaping () -> ()){
        
        //This is the information that will be sent to the server to authenticate our device
        let requestURL = "https://api.lufthansa.com/v1/oauth/token" //FIXME
        let parameters = ["client_id": "\(clientID)", "client_secret" : "\(clientSecret)", "grant_type" : "client_credentials"] //FIXME
        
        //GET RID OF THIS
        //completion()
        
        //This is the POST request made to the lufthansa servers to get the authToken for this session.
        Alamofire.request(requestURL, method: .post , parameters: parameters, encoding: URLEncoding()).responseJSON { response in
         
         //Converts response to JSON object and sets authToken variable to appropriate value
         let json = JSON(response.result.value) //FIXME
         self.authToken = json["access_token"].stringValue//FIXME
         
         print("Auth token: " + self.authToken!)
         print("This key expires in " + json["expires_in"].stringValue + " seconds\n")
         
         //Runs completion closure
         completion()
         }
    }
    
    //This function will get the status for a flight. FlightNum format "LHXXX" Date format "YYYY-MM-DD"
    static func getFlightStatus(flightNum: String, date: String, completion: @escaping (Flight) -> ()){
        
        //Request URL and authentication parameters
        let requestURL = "https://api.lufthansa.com/v1/operations/flightstatus/\(flightNum)/\(date)"
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization" : "Bearer \(self.authToken!)"]
        
        //print("PARAMETERS FOR REQUEST:")
        //print(parameters)
        //print("\n")
        
        //GET RID OF THIS
        //completion(Flight())
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
         //Makes sure that response is valid
         guard response.result.isSuccess else {
         print(response.result.error.debugDescription)
         return
         }
         //Creates JSON object
         let json = JSON(response.result.value) //FIXME
         //print(json)
         //Create new flight model and populate data
         let data = json["FlightStatusResource"]["Flights"]["Flight"]
         let flight = Flight(data: data)
         //FIXME
         completion(flight)
         }
    }
    
    static func getAirport(airportCode: String, completion: @escaping (Airport) -> ()) {
        let requestURL = "https://api.lufthansa.com/v1/references/airports/\(airportCode)?lang=en"
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization" : "Bearer \(self.authToken!)"]
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            //print(json)
            //Create new airport model and populate data
            let data = json["AirportResource"]["Airports"]["Airport"]
            let airport = Airport(data: data)
            //FIXME
            completion(airport)
        }
    }
    
    static func getLHAirports(completion: @escaping ([Airport]) -> ()) {
        let requestURL = "https://api.lufthansa.com/v1/references/airports/?lang=en&limit=100&LHoperated=1"
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization" : "Bearer \(self.authToken!)"]
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            //print(json)
            //Create new airport model and populate data
            let airports = json["AirportResource"]["Airports"]["Airport"].arrayValue
            var returnAirports: [Airport] = []
            for i in 0..<airports.count {
                returnAirports.append(Airport(data: airports[i]))
            }
            //FIXME
            completion(returnAirports)
        }
    }
    
    static func getFlightsFrom(type: String, airportCode: String, currentDate: String, completion: @escaping ([Flight]) -> ()) {
        let requestURL = "https://api.lufthansa.com/v1/operations/flightstatus/\(type)/\(airportCode)/\(currentDate)"
        //print(requestURL)
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization" : "Bearer \(self.authToken!)"]
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            //print(json)
            //Create new airport model and populate data
            let flights = json["FlightStatusResource"]["Flights"]["Flight"].arrayValue
            var returnFlights: [Flight] = []
            for i in 0..<flights.count {
                returnFlights.append(Flight(data: flights[i]))
            }
            //FIXME
            completion(returnFlights)
        }
    }
    
    static func getAircraft(type: String, completion: @escaping (Aircraft) -> ()) {
        let requestURL = "https://api.lufthansa.com/v1/references/aircraft/\(type)"
        //print(requestURL)
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization" : "Bearer \(self.authToken!)"]
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            //print(json)
            //Create new airport model and populate data
            //FIXME
            completion(Aircraft(data: json))
        }
    }
    
}
