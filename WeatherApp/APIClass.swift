//
//  APIClass.swift
//  WeatherApp
//
//  Created by Nathan Sharma on 27/02/2019.
//  Copyright © 2019 Nathan Sharma. All rights reserved.
//

import Foundation

//let url = "http://api.openweathermap.org/data/2.5/forecast?id=2643743&APPID=56dfecee0dd415cedd94d1b1ab8dae73"

import Foundation
import CoreLocation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents? {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}

enum WeatherAPIEndpoint: Endpoint {
    
    case forcast(_ location: CLLocationCoordinate2D)
    
    var baseUrl: String {
        return "https://api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .forcast(_):
            return "/data/2.5/forecast"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        // All requests should be using the same key/appid
        var params = [URLQueryItem(name: "appid", value: "c92dcc692369a6eea28dcb9d0356c36a")]
        
        switch self {
        case .forcast(let location):
            params.append(URLQueryItem(name: "lat", value: String(location.latitude)))
            params.append(URLQueryItem(name: "lon", value: String(location.longitude)))
        }
        
        return params
    }
}

protocol dataFetcher {

    func get(_ request: Endpoint, completion: @escaping (_ result: Result<WeatherInfoList>) -> Void)
}

class BasicWeatherFetcher: dataFetcher {


    private let session: URLSession
    
    init(_ session: URLSession) {
        self.session = session
    }

    func get(_ request: Endpoint, completion: @escaping (_ result: Result<WeatherInfoList>) -> Void) {

        guard let urlRequest = request.request else {
            completion(.failure(self.errorObject(999, domain: "User", description: "URL Error")))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let da = data, error == nil else {
                completion(.failure(self.errorObject(999, domain: "User", description: "Unkonwn")))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                if let weatherInfo = try? jsonDecoder.decode(WeatherInfoList.self, from: da) {
                    completion(.success(weatherInfo))
                }
                else {
                    completion(.failure(self.errorObject(999, domain: "User", description: "error parsing data Unknown")))

                }
            }
        }

        dataTask.resume()
    }


    func errorObject(_ code: Int, domain: String, description: String) -> NSError {
        let error = NSError.init(domain: domain,
                                 code: code,
                                 userInfo: [NSLocalizedDescriptionKey: description])
        return error
    }
}

