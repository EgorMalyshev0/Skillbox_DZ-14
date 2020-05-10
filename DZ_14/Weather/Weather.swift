import Foundation
import RealmSwift

class Weather: Object {
    
    @objc dynamic var cityName: String = ""
    @objc dynamic var weather: String = ""
    @objc dynamic var temp: Double = 0
    @objc dynamic var feels: Double = 0
    @objc dynamic var visibility: Int = 0
    @objc dynamic var wind: Double = 0
    
    convenience init?(data: NSDictionary){
        guard let name = data["name"] as? String,
            let main = data["main"] as? NSDictionary,
            let temp = main["temp"] as? Double,
            let feels = main["feels_like"] as? Double,
            let visibility = data["visibility"] as? Int,
            let weatherArray = data["weather"] as? NSArray,
            let weatherDict = weatherArray[0] as? NSDictionary,
            let weather = weatherDict["description"] as? String,
            let windDict = data["wind"] as? NSDictionary,
            let wind = windDict["speed"] as? Double
            else {
            return nil
        }
        self.init()
        cityName = name
        self.temp = temp
        self.feels = feels
        self.weather = weather
        self.visibility = visibility
        self.wind = wind
    }
}
