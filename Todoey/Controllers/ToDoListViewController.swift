//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Ramon Seoane Martin on 3/6/23.
//

import UIKit

class ToDoListViewController: UITableViewController {

	var itemArray = [Item]()
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		let newItem = Item()
		newItem.title = "Find Mike"
		newItem.done = true
		itemArray.append(newItem)
		
		let newItem2 = Item()
		newItem2.title = "Buy Eggs"
		itemArray.append(newItem2)
		
		let newItem3 = Item()
		newItem3.title = "Destroy Demogorgon"
		itemArray.append(newItem3)
		
		
//		if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//			itemArray = items
//		}
	}

	
	//MARK: - TableView DataSource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		let item = itemArray[indexPath.row]

		cell.textLabel?.text = item.title
		cell.accessoryType = item.done ? .checkmark : .none /// Ternary Operator ==> value = condition ? valueIfTrue : valueIfFalse
				
		return cell
	}

	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Fila de la celda seleccionada: \(indexPath.row)")
		print("Elemento de la celda seleccionada: \(itemArray[indexPath.row].title)")
		print()
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	//MARK: - Private Functions
	func updateCheck(_ indexPath: IndexPath) {
		
		if itemArray[indexPath.row].done == false {
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
			
			let newItem = Item()
			newItem.title = textField.text!
			self.itemArray.append(newItem) /// add to the Items Array
			self.tableView.reloadData()
			
			self.defaults.set(self.itemArray, forKey: "ToDoListArray") /// add to our User Defaults
			
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

