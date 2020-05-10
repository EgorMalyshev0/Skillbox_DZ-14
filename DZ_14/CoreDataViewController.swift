import UIKit
import CoreData

class CoreDataViewController: UIViewController {

    @IBOutlet weak var coreDataTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Adding task", message: "Type your task in the textfield", preferredStyle: .alert)
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            let textField = alert.textFields?.first
            if let text = textField?.text {
                Persistance.shared.addData(name: text)
                self.coreDataTableview.reloadData()
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter task"
        }
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
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
