
import Foundation
import CoreLocation

protocol ForecastManagerDelegate {
    func didUpdateForecast(_ forecastManager: ForecastManager, forecast: ForecastModel)
    func didFailWithForecastError(error: Error)
}

struct ForecastManager {
    let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?appid=19d874becf72a32aab089a9a0a0bc862&units=metric"
    
    var delegate: ForecastManagerDelegate?
    
    func fetchForecast(cityName: String) {
        let urlString = "\(forecastURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(forecastURL)&lat=\(latitude)&lon=\(longitude)"
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
                    self.delegate?.didFailWithForecastError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let forecast = self.parseJSON(safeData){
                        self.delegate?.didUpdateForecast(self, forecast: forecast)
                    }
                }
            }
            
            //          4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            let tempDay1 = decodedData.list[4].main.temp
            let tempDay2 = decodedData.list[12].main.temp
            let tempDay3 = decodedData.list[20].main.temp
            let tempDay4 = decodedData.list[28].main.temp
            let tempDay5 = decodedData.list[36].main.temp
            
            let id1 = decodedData.list[4].weather[0].id
            let id2 = decodedData.list[12].weather[0].id
            let id3 = decodedData.list[20].weather[0].id
            let id4 = decodedData.list[28].weather[0].id
            let id5 = decodedData.list[36].weather[0].id
            
            let forecast = ForecastModel(conditionId1: id1, conditionId2: id2, conditionId3: id3, conditionId4: id4, conditionId5: id5, temperatureDay1: tempDay1, temperatureDay2: tempDay2, temperatureDay3: tempDay3, temperatureDay4: tempDay4, temperatureDay5: tempDay5)
            return forecast
            
        } catch {
            delegate?.didFailWithForecastError(error: error)
            return nil
        }
    }
    
}

