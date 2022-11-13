//
//  Model.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/13.
//

import Foundation

struct FiveDays: Codable {
    var cod: String
    var message: Int
    var count: Int
    var list: [List]
    var city: City
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case count = "cnt"
        case list = "list"
        case city = "city"
    }
    
    init() {
        self.cod = ""
        self.message = 0
        self.count = 0
        self.list = []
        self.city = City()
    }
}
struct Current: Codable {
    var coord: Coord
    var weather : Weather
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Info
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    init() {
        self.coord = Coord()
        self.weather = Weather()
        self.base = ""
        self.main = Main()
        self.visibility = 0
        self.wind = Wind()
        self.clouds = Clouds()
        self.dt = 0
        self.sys = Info()
        self.timezone = 0
        self.id = 0
        self.name = ""
        self.cod = 0
    }
}
struct List: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var visibility: Int
    var pop: Float
    var sys: Sys
    var date: String
    
    enum CodingKeys: String, CodingKey {
        
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case sys = "sys"
        case date = "dt_txt"
    }
    
    init() {
        self.dt = 0
        self.main = Main()
        self.weather = []
        self.clouds = Clouds()
        self.wind = Wind()
        self.visibility = 0
        self.pop = 0.0
        self.sys = Sys()
        self.date = ""
    }
}
struct City: Codable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var population: Int
    var timezone: Int
    var sunrise: Int
    var sunset: Int
    
    init() {
        self.id = 0
        self.name = ""
        self.coord = Coord()
        self.country = ""
        self.population = 0
        self.timezone = 0
        self.sunrise = 0
        self.sunset = 0
    }
}
struct Coord: Codable {
    var lon: Float
    var lat: Float
    
    init() {
        self.lon = 0.0
        self.lat = 0.0
    }
}
struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init() {
        self.id = 0
        self.main = ""
        self.description = ""
        self.icon = ""
    }
}
struct Main: Codable {
    var temp: Float
    var feels: Float
    var min: Float
    var max: Float
    var pressure: Int
    var sea: Int
    var ground: Int
    var humidity: Int
    var kf: Float
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case feels = "feels_like"
        case min = "temp_min"
        case max = "temp_max"
        case pressure = "pressure"
        case sea = "sea_level"
        case ground = "grnd_level"
        case humidity = "humidity"
        case kf = "temp_kf"
    }
    
    init() {
        self.temp = 0.0
        self.feels = 0.0
        self.min = 0.0
        self.max = 0.0
        self.pressure = 0
        self.sea = 0
        self.ground = 0
        self.humidity = 0
        self.kf = 0.0
    }
}
struct Clouds: Codable {
    var all: Int = 0
}
struct Wind: Codable {
    var speed: Float
    var deg: Int
    var gust: Float
    
    init() {
        self.speed = 0.0
        self.deg = 0
        self.gust = 0.0
    }
}
struct Rain: Codable {
    var three: Float = 0.0
    
    enum CodingKeys: String, CodingKey {
        case three = "3h"
    }
}
struct Snow: Codable {
    var three: Float = 0.0
    
    enum CodingKeys: String, CodingKey {
        case three = "3h"
    }
}
struct Sys: Codable {
    var pod: String = ""
}
struct Info: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
    
    init() {
        self.type = 0
        self.id = 0
        self.country = ""
        self.sunrise = 0
        self.sunset = 0
    }
}
