//
//  BaseRowModel.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class BaseRowModel<T>: NSObject {
    // Row Item
    var rowCellIdentifier = ""
    var rowValue: T?
}
