//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Ramon Seoane Martin on 3/6/23.
//

import UIKit

class ToDoListViewController: UITableViewController {

	var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	
	//MARK: - TableView DataSource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}

	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Fila de la celda seleccionada: \(indexPath.row)")
		print("Elemento de la celda seleccionada: \(itemArray[indexPath.row])")
		print()
		
		updateCheck(indexPath)
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	//MARK: - Private Functions
	func updateCheck(_ indexPath: IndexPath) {
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
	}
	
	//MARK: - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			// Whatever happens once the Add Item buttom on our UIAlert is pressed
			self.itemArray.append(textField.text!)
			self.tableView.reloadData()
			
			print("Entered --> \(textField.text!)")
			print()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		
		present(alert,animated: true, completion: nil)
		
	}
	
	
}

