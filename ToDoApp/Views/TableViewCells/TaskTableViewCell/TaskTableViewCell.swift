//
//  TaskTableViewCell.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class TaskTableViewCell: BaseTableViewCell<Task> {

    @IBOutlet weak var lblTaskTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func updateCell(data: Task?) { // Cell content updated with Task data
        if let task = data {
            lblTaskTitle.text = task.name
        }
    }
    
}
