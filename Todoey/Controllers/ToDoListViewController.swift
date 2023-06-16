//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Ramon Seoane Martin on 3/6/23.
//

import UIKit

class ToDoListViewController: UITableViewController {

	var itemArray = [Item]()
	
	
	// File path to the documents folder
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		print(dataFilePath!)
		print()
		
		loadItems()		
	}

	
	//MARK: - TableView DataSource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		let item = itemArray[indexPath.row]

		cell.textLabel?.text = item.title
		cell.accessoryType = item.done ? .checkmark : .none /// Ternary Operator ==> VALUE = CONDITION ? VALUETRUE : VALUEFALSE
				
		return cell
	}

	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Fila de la celda seleccionada: \(indexPath.row)")
		print("Elemento de la celda seleccionada: \(itemArray[indexPath.row].title)")
		print()
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		self.saveItems()
		
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
			
			self.saveItems()
		}
		
		// Add a textfield to the alert
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		// Add an action to the alert
		alert.addAction(action)
		
		present(alert,animated: true, completion: nil)
		
	}
	

	//MARK: - Model Manipulation Methods
	func saveItems() {
		
		let encoder = PropertyListEncoder()
		
		do {
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
		} catch {
			print("Error encoding item array, \(error)")
		}
		
		self.tableView.reloadData()
	}
	
	func loadItems() {
		
		if let data = try? Data(contentsOf: dataFilePath!) {
			
			let decoder = PropertyListDecoder()
			
			do {
				itemArray = try decoder.decode([Item].self, from: data)
			} catch {
				print("Error encoding item array, \(error)")
			}
		}
		
		self.tableView.reloadData()
	}
}

