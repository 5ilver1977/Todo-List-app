//
//  TaskViewController.swift
//  toDoListApp
//
//  Created by usuario on 8/8/22.
//

import UIKit

protocol TaskViewControllerDelegate: AnyObject {
    func deleteTask(row: Int)
}

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    weak var delegate: TaskViewControllerDelegate?
    
    var task: String?
    var currentPosition: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))

        
    }

    @objc
    func deleteTask() {
        delegate?.deleteTask(row: currentPosition)
        navigationController?.popViewController(animated: true)
    }

    
}
