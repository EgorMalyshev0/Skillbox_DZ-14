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
    private let kCurrentWeatherKey = "Persistance.kCurrentWeatherKey"
    private let kForecastKey = "Persistance.kForecastKey"
    
    var name: String? {
        set {UserDefaults.standard.set(newValue, forKey: kNameKey)}
        get {UserDefaults.standard.string(forKey: kNameKey)}
    }
    
    var surname: String? {
        set {UserDefaults.standard.set(newValue, forKey: kSurnameKey)}
        get {UserDefaults.standard.string(forKey: kSurnameKey)}
    }
    
    var currentWeather: NSDictionary? {
        set { UserDefaults.standard.set(newValue, forKey: kCurrentWeatherKey) }
        get { UserDefaults.standard.object(forKey: kCurrentWeatherKey) as? NSDictionary }
    }
    
    var forecasts: NSDictionary? {
        set { UserDefaults.standard.set(newValue, forKey: kForecastKey) }
        get { UserDefaults.standard.object(forKey: kForecastKey) as? NSDictionary }
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
    
    // CoreData
    func addData(_ name: String) {
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
