//
//  BaseTableViewCell.swift
//  ToDoApp
//
//  Created by Khawar Shahzad on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class BaseTableViewCell<T>: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(data: T?) {
        preconditionFailure("You have to override updateCell")
    }

}
