import Foundation

class Weather: NSObject, NSCoding {
    
    let cityName: String
    let weather: String
    let temp: Double
    let feels: Double
    let visibility: Int
    let wind: Double
    
    init?(data: NSDictionary){
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
        cityName = name
        self.temp = temp
        self.feels = feels
        self.weather = weather
        self.visibility = visibility
        self.wind = wind
        
    }
    func encode(with coder: NSCoder) {
        coder.encode(cityName, forKey: "cityName")
        coder.encode(weather, forKey: "weather")
        coder.encode(temp, forKey: "temp")
        coder.encode(feels, forKey: "feels")
        coder.encode(visibility, forKey: "visibility")
        coder.encode(wind, forKey: "wind")
    }
    
    required init?(coder: NSCoder) {
        cityName = coder.decodeObject(forKey: "cityName") as? String ?? ""
        weather = coder.decodeObject(forKey: "weather") as? String ?? ""
        temp = coder.decodeObject(forKey: "temp") as? Double ?? 0
        feels = coder.decodeObject(forKey: "feels") as? Double ?? 0
        visibility = coder.decodeObject(forKey: "visibility") as? Int ?? 0
        wind = coder.decodeObject(forKey: "wind") as? Double ?? 0
    }
}
