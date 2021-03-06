import UIKit

class ForecastViewController: UIViewController {

    var forecasts: [Forecast] = []
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let forecasts = Persistance.shared.retrieveForecasts() {
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
