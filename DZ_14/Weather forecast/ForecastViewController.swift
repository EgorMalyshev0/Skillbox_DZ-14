import UIKit

class ForecastViewController: UIViewController {

    var forecasts: [Forecast] = []
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let jsonDict = Persistance.shared.forecasts {
            var forecasts: [Forecast] = []
            if let forecastArray = jsonDict["list"] as? NSArray{
                for data in forecastArray where data is NSDictionary {
                    if let forecast = Forecast(data: data as! NSDictionary){
                        forecasts.append(forecast)
                    }
                }
            }
            self.forecasts = forecasts
            self.forecastTableView.reloadData()
        }
        
        ForecastLoader().forecastLoader { forecasts in
            self.forecasts = forecasts
            self.forecastTableView.reloadData()
        }
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell") as! ForecastTableViewCell
        let model = forecasts[indexPath.row]
        cell.dateLabel.text = model.date
        cell.weatherLabel.text = model.weather
        cell.tempLabel.text = "\(Int(model.temp)) ºC"
        return cell
    }
}
