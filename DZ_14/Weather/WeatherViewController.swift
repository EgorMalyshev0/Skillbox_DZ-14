import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let jsonDict = Persistance.shared.currentWeather {
            if let weather = Weather(data: jsonDict){
                self.loadWeather(weather: weather)
            }
        }
        
        WeatherLoader().weatherLoader { weather in
            self.loadWeather(weather: weather)
        }
    }
    
    func loadWeather (weather: Weather) {
        self.nameLabel.text = weather.cityName
        self.weatherLabel.text = weather.weather
        self.tempLabel.text = "\(Int(weather.temp)) ºC"
        self.windLabel.text = "\(weather.wind) м/с"
        self.feelsLabel.text = "\(Int(weather.feels)) ºC"
        self.visibilityLabel.text = "\(weather.visibility)"
    }
}
    
