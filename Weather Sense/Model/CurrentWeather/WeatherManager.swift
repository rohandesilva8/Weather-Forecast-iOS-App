
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=19d874becf72a32aab089a9a0a0bc862&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
//        1. Create a URL
        
        if let url = URL(string: urlString) {
//          2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            
//          3. Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
//          4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed
            let visibility = decodedData.visibility / 1000
            let cloudiness = decodedData.clouds.all
            let sunriseDate = Date(timeIntervalSince1970: TimeInterval(decodedData.sys.sunrise))
            let sunsetDate = Date(timeIntervalSince1970: TimeInterval(decodedData.sys.sunset))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            let sunriseTimeString = dateFormatter.string(from: sunriseDate)
            let sunsetTimeString = dateFormatter.string(from: sunsetDate)
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, humidity: humidity, windSpeed: windSpeed, visibility: Double(visibility), cloudiness: cloudiness, sunriseTime: sunriseTimeString, sunsetTime: sunsetTimeString)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
