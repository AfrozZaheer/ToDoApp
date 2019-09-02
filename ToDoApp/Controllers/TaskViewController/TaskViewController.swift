//
//  BaseViewController.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController { // Generalization of task

    @IBOutlet weak var tableView: UITableView!
    internal var content = [BaseRowModel<Task>]()
    let taskManager = TaskManager.sharedManager
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCells()
        
        NotificationCenter.default.addObserver(forName: .taskTypeChange, object: nil, queue: nil) {[weak self] (_) in
            guard let `self` = self else {return}
            self.reloadTableView()
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    internal func reloadTableView() {tableView.reloadData()}
    
    func registerNibCells() {
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = content[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: data.rowCellIdentifier) as? BaseTableViewCell<Task> else {return UITableViewCell()}
        
        cell.updateCell(data: data.rowValue)
        
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
                }
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
                if task.taskIdentifier == taskToCompare.taskIdentifier {
                    if task.type == .Done {
                        task.type = .Pending
                    } else {
                        task.type = .Done
                    }
                }
            }
            NotificationCenter.default.post(name: .taskTypeChange, object: nil)
        }
    }
}
