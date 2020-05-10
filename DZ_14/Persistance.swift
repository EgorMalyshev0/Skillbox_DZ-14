import UIKit
import RealmSwift
import CoreData

class ToDoItem: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var isCompleted: Bool = false
}

class Persistance {
    static let shared = Persistance()
    
    // UserDefaults
    private let kNameKey = "Persistance.kNameKey"
    private let kSurnameKey = "Persistance.kSurnameKey"
    
    var name: String? {
        set {UserDefaults.standard.set(newValue, forKey: kNameKey)}
        get {UserDefaults.standard.string(forKey: kNameKey)}
    }
    
    var surname: String? {
        set {UserDefaults.standard.set(newValue, forKey: kSurnameKey)}
        get {UserDefaults.standard.string(forKey: kSurnameKey)}
    }

    // Realm
    private let realm = try! Realm()
    
    func count() -> Int {
        let allToDos = realm.objects(ToDoItem.self)
        return allToDos.count
    }
    
    func toDo(_ index: Int) -> ToDoItem {
        let allToDos = realm.objects(ToDoItem.self)
        let toDo = allToDos[index]
        return toDo
    }
    
    func addItem(_ toDo: ToDoItem) {
        try! realm.write{
            realm.add(toDo)
        }
    }
    
    func removeItem(_ toDo: ToDoItem) {
        try! realm.write{
            realm.delete(toDo)
        }
    }
    
    func changeCompletion(_ index: Int) -> Bool {
        let allToDos = realm.objects(ToDoItem.self)
        try! realm.write{
            allToDos[index].isCompleted = !allToDos[index].isCompleted
        }
        return allToDos[index].isCompleted
    }
    
    func addWeather(_ item: Object) {
        try! realm.write{
            realm.add(item)
        }
    }
    
    func retrieveWeather() -> Weather? {
        let allWeather = realm.objects(Weather.self)
        if allWeather.count != 0 {
            let weather = allWeather[0]
            return weather
        } else {
        return nil
        }
    }
    
    func retrieveForecasts() -> [Forecast]? {
        var forecasts: [Forecast] = []
        let allForecast = realm.objects(Forecast.self)
        if allForecast.count != 0 {
            for forecast in allForecast {
                forecasts.append(forecast)
            }
            return forecasts
        } else {
        return nil
        }
    }
    
    func removeWeather() {
        let allWeather = realm.objects(Weather.self)
        try! realm.write{
            realm.delete(allWeather)
        }
    }
    
    func removeForecast() {
        let allForecast = realm.objects(Forecast.self)
        try! realm.write{
            realm.delete(allForecast)
        }
    }
    
    // CoreData
    func addData(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDo", in: managedContext)!
        let toDo = NSManagedObject(entity: entity, insertInto: managedContext)
        toDo.setValue(name, forKey: "name")
        do {
            try managedContext.save()
        } catch {
            print("Error")
        }
    }
    
    func retrieveData() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            return result
        } catch {
            print("Error")
            return []
        }
    }
    
    func deleteData(_ index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            let objectToDelete = result[index]
            managedContext.delete(objectToDelete)
            do {
                try managedContext.save()
            } catch {
                print("Error")
            }
        } catch {
            print("Error")
        }
    }
    
    func changeCompletion2(_ index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            let objectUpdate = result[index]
            let value = objectUpdate.value(forKey: "isCompleted") as! Bool
            objectUpdate.setValue(!value, forKey: "isCompleted")
            do {
                try managedContext.save()
            } catch {
                print("Error")
            }
        } catch {
            print("Error")
        }
    }
}
