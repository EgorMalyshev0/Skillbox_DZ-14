import UIKit
import CoreData

class CoreDataViewController: UIViewController {

    @IBOutlet weak var coreDataTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addItem(_ sender: Any) {
        let number = Int.random(in: 1...100)
        Persistance.shared.addData("Item" + "\(number)")
        coreDataTableview.reloadData()
    }
    @IBAction func editButton(_ sender: Any) {
        coreDataTableview.setEditing(!coreDataTableview.isEditing, animated: true)
    }
    
}

extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Persistance.shared.retrieveData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemTableViewCell
        let name = Persistance.shared.retrieveData()[indexPath.row].value(forKey: "name") as? String
        cell.itemLabel.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Persistance.shared.changeCompletion2(indexPath.row)
        let bool = Persistance.shared.retrieveData()[indexPath.row].value(forKey: "isCompleted") as! Bool
        if bool {
            coreDataTableview.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            coreDataTableview.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Persistance.shared.deleteData(indexPath.row)
            coreDataTableview.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
