//
//  ListViewController.swift
//  GestorTareas
//
//  Created by Jose Gabriel Ferrer on 10/03/2019.
//  Copyright © 2019 Jose Gabriel Ferrer. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var taskManager = TaskManager.sharedInstance
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! TaskCell
        let task = taskManager.tasks[indexPath.row]
        
        cell.lblTask.text = task["title"]
        
        if let image = task["icon"] {
            cell.imgTask.image = UIImage(named: image)
        } else {
            cell.imgTask.image = UIImage(named: "icon-no-icon")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Nueva tarea", message: "Nombre de la tarea", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let alertAction = UIAlertAction(title: "Guardar", style: .default) { (alertAction) in
            if let textFieldText = alertController.textFields?.first?.text {
                self.taskManager.tasks.append(["title": textFieldText])
                
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let complete = UITableViewRowAction(style: .normal, title: "Completar") { (action, indexPath) in
            self.taskManager.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        complete.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5098039216, blue: 0.8509803922, alpha: 1)
        
        return [complete]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! IconsViewController
                
                let selectedTask = taskManager.tasks[indexPath.row]
                destinationVC.headerTitleString = selectedTask["title"]
                destinationVC.selectedTask = indexPath.row
            }
        }
    }
    
}
