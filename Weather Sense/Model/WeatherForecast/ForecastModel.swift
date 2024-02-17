
import Foundation

struct ForecastModel {
    
    let conditionId1: Int
    let conditionId2: Int
    let conditionId3: Int
    let conditionId4: Int
    let conditionId5: Int
    
    let temperatureDay1: Double
    let temperatureDay2: Double
    let temperatureDay3: Double
    let temperatureDay4: Double
    let temperatureDay5: Double
    
    
    var temperatureString1: String {
        return String(format: "%.0f", temperatureDay1)
    }
    
    var temperatureString2: String {
        return String(format: "%.0f", temperatureDay2)
    }
    
    var temperatureString3: String {
        return String(format: "%.0f", temperatureDay3)
    }
    
    var temperatureString4: String {
        return String(format: "%.0f", temperatureDay4)
    }
    
    var temperatureString5: String {
        return String(format: "%.0f", temperatureDay5)
    }
    
    
    
    func conditionName(for conditionId: Int) -> String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    func conditionNamesForDays() -> [String] {
        let conditionNames = [
            conditionName(for: conditionId1),
            conditionName(for: conditionId2),
            conditionName(for: conditionId3),
            conditionName(for: conditionId4),
            conditionName(for: conditionId5)
        ]
        return conditionNames
    }
}

