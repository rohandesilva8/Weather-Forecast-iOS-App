
import Foundation

struct ForecastData: Codable {
    let list: [ForecastList]
}

struct ForecastList: Codable {
    let main: MainList
    let weather: [WeatherList]
}

struct MainList: Codable {
    let temp: Double
}

struct WeatherList: Codable {
    let description: String
    let id: Int
}




