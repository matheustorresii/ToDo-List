//
//  ViewController.swift
//  TodoList
//
//  Created by Matheus Torres on 19/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var todoList: [String] = []
  let listKey: String = "todolist"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    
    if let list = UserDefaults.standard.value(forKey: listKey) as? [String] {
      todoList.append(contentsOf: list)
    }
  }

  @IBAction func addTask(_ sender: Any) {
    let alert = UIAlertController(title: "Nova Tarefa", message: "Adicione uma nova tarefa", preferredStyle: .alert)
    
    let actionSave = UIAlertAction(title: "Salvar", style: .default){_ in
      if let textField = alert.textFields?.first, let text = textField.text {
        self.todoList.append(text)
        self.tableView.reloadData()
        UserDefaults.standard.set(self.todoList, forKey: self.listKey)
      }
    }
    
    alert.addAction(actionSave)
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
    
    alert.addTextField()
    
    present(alert, animated: true)
  }
}

extension ViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = todoList[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      todoList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      UserDefaults.standard.set(self.todoList, forKey: self.listKey)
    }
  }
}
