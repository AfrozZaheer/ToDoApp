//
//  NSNotification+Additions.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 01/09/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

extension Notification.Name {
    // retro active approch for more readable code
    static let taskArrayUpdated = Notification.Name("TaskArrayUpdated")
    static let taskTypeChange = Notification.Name("TaskTypeChange")
    
}
