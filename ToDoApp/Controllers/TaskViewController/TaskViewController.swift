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
    }
    
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
