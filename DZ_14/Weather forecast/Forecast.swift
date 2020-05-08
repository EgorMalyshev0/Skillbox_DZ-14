import Foundation

class Forecast {

    @objc dynamic var date: String
    @objc dynamic var weather: String
    @objc dynamic var temp: Double
    
    init?(data: NSDictionary){
        guard let dt = data["dt"] as? Double,
            let weatherArray = data["weather"] as? NSArray,
            let weatherDict = weatherArray[0] as? NSDictionary,
            let weather = weatherDict["description"] as? String,
            let main = data["main"] as? NSDictionary,
            let temp = main["temp"] as? Double
            else {
            return nil
        }
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, HH:mm"
        dateFormatter.locale = Locale(identifier: "ru")
        let localDate = dateFormatter.string(from: date)
        self.date = localDate
        self.weather = weather
        self.temp = temp
    }
}
