import Foundation

class ForecastLoader {
    
    func forecastLoader(completion: @escaping ([Forecast]) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&units=metric&lang=ru&appid=375d7b6d89cd63df046676656e362e39")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                Persistance.shared.forecasts = jsonDict
                var forecasts: [Forecast] = []
                if let forecastArray = jsonDict["list"] as? NSArray{
                    for data in forecastArray where data is NSDictionary {
                        if let forecast = Forecast(data: data as! NSDictionary){
                            forecasts.append(forecast)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(forecasts)
                    }
                }
            }
        }
        task.resume()
    }
}
