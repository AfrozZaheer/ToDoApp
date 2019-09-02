//
//  PendingTaskViewController.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class PendingTaskViewController: TaskViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        content = taskManager.pendingTasks
        NotificationCenter.default.addObserver(forName: .taskArrayUpdated, object: nil, queue: nil) {[weak self] (notification) in
            self?.updateTableViewData()
        }
        updateTableViewData()
    }
    
    override func reloadTableView() { // called when data in main array type changes
        content = taskManager.pendingTasks
        super.reloadTableView()
    }
    
    // MARK: - Utility Methods
    
    fileprivate func updateTableViewData() { // called upon when data in main array added or deleted
        content = taskManager.pendingTasks
    }
    
    // MARK: - IBAction

    @IBAction func didClickedAddTask(_ sender: UIBarButtonItem) {
        presentNewTaskAlert()
    }
    
}
//MARK: Utility Methods

extension PendingTaskViewController {
    fileprivate func presentNewTaskAlert() {
        UIAlertController.showAlertWithTextFieldToEnterTask(parentVC: self, success: {[weak self] (title) in
            guard let `self` = self else {return} // creating self name local variable and make it in guard statement
            self.createNewTask(name: title)
        }) {
            UIAlertController.showAlert(title: "", message: "Please enter task name", parentVC: self)
        }
    }
    
    
    fileprivate func createNewTask(name: String) { // create wrapper around data for general use for better understanding and reusability. this approch can be used on data from Api for cleaner code
        let task = Task(name: name, type: .Pending)
        
        let rowModel = BaseRowModel<Task>()
        rowModel.rowCellIdentifier = "TaskTableViewCell"
        rowModel.rowValue = task
        taskManager.allTasks.append(rowModel)
        tableView.reloadData()
    }
}
