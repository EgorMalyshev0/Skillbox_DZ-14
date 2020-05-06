//
//  RealmViewController.swift
//  DZ_14
//
//  Created by Egor Malyshev on 28.04.2020.
//  Copyright © 2020 Egor Malyshev. All rights reserved.
//

import UIKit

class RealmViewController: UIViewController {

    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addItem(_ sender: Any) {
        let number = Int.random(in: 1...100)
        let toDo = ToDoItem()
        toDo.name = "ToDoItem\(number)"
        Persistance.shared.addItem(toDo)
        itemsTableView.reloadData()
    }
    @IBAction func editButton(_ sender: Any) {
        itemsTableView.setEditing(!itemsTableView.isEditing, animated: true)
    }
    
}

extension RealmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Persistance.shared.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemTableViewCell
        let toDo = Persistance.shared.toDo(indexPath.row)
        cell.itemLabel.text = toDo.name
        if toDo.isCompleted == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if Persistance.shared.changeCompletion(indexPath.row) {
            itemsTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            itemsTableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = Persistance.shared.toDo(indexPath.row)
            Persistance.shared.removeItem(item)
            itemsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
