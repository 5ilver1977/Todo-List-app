//
//  EntryViewController.swift
//  toDoListApp
//
//  Created by usuario on 8/8/22.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
        
    }
        
    @objc func saveTask() {
        guard let text = field.text, !text.isEmpty else {
            return
        }

        //TODO: mover al delegate
//        delegate?.saveTask(text: text)
        let defaults = UserDefaults.standard
        var tasks = defaults.stringArray(forKey: "tasks") ?? [String]()
        tasks.append(text)

        defaults.set(tasks, forKey: "tasks")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }

    

}
