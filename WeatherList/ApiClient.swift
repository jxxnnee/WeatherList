//
//  ApiClient.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/13.
//

import Foundation
import Alamofire

struct ApiClient {
    static var `default` = ApiClient()
    
    func getFiveDaysWeather(country: String, completionHandler: @escaping () -> Void) {
        AF.request(Endpoint.requestGetFiveDaysWeather(country: country))
            .responseString { res in
                switch res.result {
                case .success(let str):
                    print(str)
                case .failure(let err):
                    print("ERROR: ", err.errorDescription)
                }
            }
    }
    
    func getCurrentWeather(country: String, completionHandler: @escaping () -> Void) {
        AF.request(Endpoint.requestGetCurrentWeather(country: country))
            .responseString { res in
                switch res.result {
                case .success(let str):
                    print(str)
                case .failure(let err):
                    print("ERROR: ", err.errorDescription)
                }
            }
    }
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    
    func encodeData(with request: URLRequest) throws -> URLRequest
    func asURLRequest() throws -> URLRequest
}

enum Endpoint: APIConfiguration {
    case requestGetCurrentWeather(country: String)
    case requestGetFiveDaysWeather(country: String)
    
    var baseURL: String {
        get {
            return "https://api.openweathermap.org/data/2.5"
        }
    }
    var apiKey: String {
        get {
            return "a73073af702abde41851e5bcaf776200"
        }
    }
    var method: HTTPMethod {
        get {
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .requestGetCurrentWeather:
            return "weather"
        case .requestGetFiveDaysWeather:
            return "forecast"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .requestGetCurrentWeather(let country):
            return [
                "q": country,
                "units": "metric",
                "lang": "kr",
                "appid": apiKey
            ]
        case .requestGetFiveDaysWeather(let country):
            return [
                "q": country,
                "cnt": "40",
                "units": "metric",
                "lang": "kr",
                "appid": apiKey
            ]
        }
    }
    
    func encodeData(with request: URLRequest) throws -> URLRequest {
        return try URLEncoding.queryString.encode(request, with: parameters)
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
                
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        
        return try self.encodeData(with: request)
    }
    
    
}
