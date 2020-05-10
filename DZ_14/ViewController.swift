import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var surnameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextfield.text = Persistance.shared.name
        surnameTextfield.text = Persistance.shared.surname
    }

    @IBAction func saveButton(_ sender: Any) {
        Persistance.shared.name = nameTextfield.text
        Persistance.shared.surname = surnameTextfield.text
    }
    
}

