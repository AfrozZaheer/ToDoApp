//
//  BaseViewController.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController { // Generalization of task controller

    @IBOutlet weak var tableView: UITableView!
    internal var content = [BaseRowModel<Task>]() // Signle array containg data for tableview internal so can be protect while accessable to child class
    let taskManager = TaskManager.sharedManager // manager which manages the task
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCells()
        
        NotificationCenter.default.addObserver(forName: .taskTypeChange, object: nil, queue: nil) {[weak self] (_) in
            guard let `self` = self else {return}
            self.reloadTableView() // this notification fired when state of task change from completed to pending or pending to completed
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    internal func reloadTableView() {tableView.reloadData()}
    
    func registerNibCells() {
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell") // signle cell used on multiple controllers so make Nib to reduce multiplication
    }
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = content[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: data.rowCellIdentifier) as? BaseTableViewCell<Task> else {return UITableViewCell()}
        
        cell.updateCell(data: data.rowValue) // Applying generalization approch for the tableview cells
        
        return cell
    }
    
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let rowSwiped = content[indexPath.row]
            taskManager.allTasks.removeAll { (model) -> Bool in
                if let task = model.rowValue, let taskToRemoved = rowSwiped.rowValue {
                    if (task.name == taskToRemoved.name) && (task.taskIdentifier == taskToRemoved.taskIdentifier) {
                        return true
                    }
                } // remove particular task from the main array and reload that row
                return false
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowModel = content[indexPath.row]
        taskManager.allTasks.forEach { (model) in
            if let task = rowModel.rowValue, let taskToCompare = model.rowValue {
                if task.taskIdentifier == taskToCompare.taskIdentifier { // changing the type of task
                    if task.type == .Done {
                        task.type = .Pending
                        UIAlertController.showAlert(title: nil, message: Constants.messageTaskPending)
                    } else {
                        task.type = .Done
                        UIAlertController.showAlert(title: nil, message: Constants.messageTaskCompleted)
                    }
                }
            }
            NotificationCenter.default.post(name: .taskTypeChange, object: nil) // after change notify the controller to update its data  source...
        }
    }
}
