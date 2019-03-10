//
//  TaskManager.swift
//  GestorTareas
//
//  Created by Jose Gabriel Ferrer on 10/03/2019.
//  Copyright © 2019 Jose Gabriel Ferrer. All rights reserved.
//

import Foundation

class TaskManager  {
    
    static let sharedInstance = TaskManager()
    var tasks: [[String: String]] = [[String: String]]()
    
    func save() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
    
    func load() {
        if let array = UserDefaults.standard.array(forKey: "tasks") as? [[String: String]]{
            tasks = array
        }
    }
    
}
