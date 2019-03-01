//
//  WeatherRemoteDTO.swift
//  WeatherApp
//
//  Created by Nathan Sharma on 27/02/2019.
//  Copyright © 2019 Nathan Sharma. All rights reserved.
//

import Foundation

struct WeatherInfoList: Decodable {
    let info: [WeatherRemoteDTO]
    enum CodingKeys: String, CodingKey {
        case list
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decode([WeatherRemoteDTO].self, forKey: .list)
    }
}

struct WeatherRemoteDTO : Decodable {

    let dt: Int
    let main: TemperatureInfo
    let weather: WeatherInfo
    let wind: WindInfo
    let dt_txt: String



    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case wind
        case dt_txt
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decode(Int.self, forKey: .dt)
        main = try values.decode(TemperatureInfo.self, forKey: .main)
        weather = try values.decode([WeatherInfo].self, forKey: .weather).first!
        wind = try values.decode(WindInfo.self, forKey: .wind)
        dt_txt = try values.decode(String.self, forKey: .dt_txt)


    }

}

struct TemperatureInfo : Decodable {

    let temp_min: Float
    let temp_max: Float


    enum CodingKeys: String, CodingKey {
        case temp_min
        case temp_max

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp_min = try values.decode(Float.self, forKey: .temp_min)
        temp_max = try values.decode(Float.self, forKey: .temp_max)

    }

}


struct WeatherInfo : Decodable {

    let description: String
    let main: String


    enum CodingKeys: String, CodingKey {
        case description
        case main

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decode(String.self, forKey: .description)
        main = try values.decode(String.self, forKey: .main)

    }

}

struct WindInfo : Decodable {

    let speed: Float
    let deg: Float


    enum CodingKeys: String, CodingKey {
        case speed
        case deg

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decode(Float.self, forKey: .speed)
        deg = try values.decode(Float.self, forKey: .deg)

    }

}




