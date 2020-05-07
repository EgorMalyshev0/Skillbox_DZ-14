import Foundation

protocol WeatherLoaderDelegate {
    func loaded(weather: Weather)
}

class WeatherLoader {

    var delegate: WeatherLoaderDelegate?
    
    func weatherLoader(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Москва&units=metric&lang=ru&appid=375d7b6d89cd63df046676656e362e39")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                if let weather = Weather(data: jsonDict){
                    DispatchQueue.main.async {
                        self.delegate?.loaded(weather: weather)
                    }
                }
            }
        }
        task.resume()
    }
}
