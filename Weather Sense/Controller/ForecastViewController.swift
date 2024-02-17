
import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    var receivedForecastData: ForecastModel?

    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var firstDayLabel: UILabel!
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var thirdDayLabel: UILabel!
    @IBOutlet weak var fourthDayLabel: UILabel!
    @IBOutlet weak var fifthDayLabel: UILabel!
    
    @IBOutlet weak var firstDayNumLabel: UILabel!
    @IBOutlet weak var secondDayNumLabel: UILabel!
    @IBOutlet weak var thirdDayNumLabel: UILabel!
    @IBOutlet weak var fourthDayNumLabel: UILabel!
    @IBOutlet weak var fifthDayNumLabel: UILabel!
    
    @IBOutlet weak var firstDayTemperature: UILabel!
    @IBOutlet weak var secondDayTemperature: UILabel!
    @IBOutlet weak var thirdDayTemperature: UILabel!
    @IBOutlet weak var fourthDayTemperature: UILabel!
    @IBOutlet weak var fifthDayTemperature: UILabel!
    
    @IBOutlet weak var firstDayCondition: UIImageView!
    @IBOutlet weak var secondDayCondition: UIImageView!
    @IBOutlet weak var thirdDayCondition: UIImageView!
    @IBOutlet weak var fourthDayCondition: UIImageView!
    @IBOutlet weak var fifthDayCondition: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateDays()
        updateDayNumber()
        updateForecastUI()
        
        let topColor = UIColor(hex: "F0B86E")
        let bottomColor = UIColor(hex: "2B2A4C")
        
        backgroundView.applyGradient(topColor: topColor, bottomColor: bottomColor)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension ForecastViewController {
    
    func updateDays() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        for i in 1...5 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: currentDate) {
                switch i {
                case 1:
                    firstDayLabel.text = dateFormatter.string(from: nextDate).uppercased()
                case 2:
                    secondDayLabel.text = dateFormatter.string(from: nextDate).uppercased()
                case 3:
                    thirdDayLabel.text = dateFormatter.string(from: nextDate).uppercased()
                case 4:
                    fourthDayLabel.text = dateFormatter.string(from: nextDate).uppercased()
                case 5:
                    fifthDayLabel.text = dateFormatter.string(from: nextDate).uppercased()
                default:
                    break
                }
            }
        }
    }
    
    func updateDayNumber() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        for i in 1...5 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: currentDate) {
                switch i {
                case 1:
                    firstDayNumLabel.text = dateFormatter.string(from: nextDate)
                case 2:
                    secondDayNumLabel.text = dateFormatter.string(from: nextDate)
                case 3:
                    thirdDayNumLabel.text = dateFormatter.string(from: nextDate)
                case 4:
                    fourthDayNumLabel.text = dateFormatter.string(from: nextDate)
                case 5:
                    fifthDayNumLabel.text = dateFormatter.string(from: nextDate)
                default:
                    break
                }
            }
        }
    }
    
    func updateForecastUI() {
        if let forecastData = receivedForecastData {
    
            firstDayTemperature.text = "\(forecastData.temperatureString1)°"
            secondDayTemperature.text = "\(forecastData.temperatureString2)°"
            thirdDayTemperature.text = "\(forecastData.temperatureString3)°"
            fourthDayTemperature.text = "\(forecastData.temperatureString4)°"
            fifthDayTemperature.text = "\(forecastData.temperatureString5)°"
            
            let conditionNames = forecastData.conditionNamesForDays()
            firstDayCondition.image = UIImage(systemName: conditionNames[0])
            secondDayCondition.image = UIImage(systemName: conditionNames[1])
            thirdDayCondition.image = UIImage(systemName: conditionNames[2])
            fourthDayCondition.image = UIImage(systemName: conditionNames[3])
            fifthDayCondition.image = UIImage(systemName: conditionNames[4])
        }
    }
}





