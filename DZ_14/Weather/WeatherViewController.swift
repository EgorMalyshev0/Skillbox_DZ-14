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
        
        if let weather = Persistance.shared.currentWeather{
            nameLabel.text = weather.cityName
            weatherLabel.text = weather.weather
            tempLabel.text = "\(Int(weather.temp)) ºC"
            windLabel.text = "\(weather.wind) м/с"
            feelsLabel.text = "\(Int(weather.feels)) ºC"
            visibilityLabel.text = "\(weather.visibility)"
        }
        
        let loader = WeatherLoader()
        loader.delegate = self
        loader.weatherLoader()
    }
}

extension WeatherViewController: WeatherLoaderDelegate {
    func loaded(weather: Weather) {
        nameLabel.text = weather.cityName
        weatherLabel.text = weather.weather
        tempLabel.text = "\(Int(weather.temp)) ºC"
        windLabel.text = "\(weather.wind) м/с"
        feelsLabel.text = "\(Int(weather.feels)) ºC"
        visibilityLabel.text = "\(weather.visibility)"
        Persistance.shared.currentWeather = weather
    }
}
    
