//
//  ViewController.swift
//  toDoListApp
//
//  Created by usuario on 8/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [String]()
//    var tasks = [String: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        // get all current saved tasks
        updateTasks()
        
    }
    
    func updateTasks() {
        
        tasks.removeAll()
        
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//
//        for x in 0..<count {
//            let keyDelete = "task_\(x+1)"
//            print("keyDelete \(keyDelete)")
//            if let task = UserDefaults().value(forKey: keyDelete) as? String {
////                tasks[task] = task
//                tasks.append(task)
//            }
//        }

//        let array = ["horse", "cow", "camel", "sheep", "goat"]

        let defaults = UserDefaults.standard
//        defaults.set(tasks, forKey: "tasks")

        tasks = defaults.stringArray(forKey: "tasks") ?? [String]()
        
        tableView.reloadData()
        
    }

    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
//        vc.delegate = self
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        vc.currentPosition = indexPath.row
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
}

extension ViewController: TaskViewControllerDelegate {
    func deleteTask(row: Int) {
        let defaults = UserDefaults.standard
        var tasks = defaults.stringArray(forKey: "tasks") ?? [String]()
        tasks.remove(at: row)

        defaults.set(tasks, forKey: "tasks")

        updateTasks()
        tableView.reloadData()
    }
}

//TODO: ENTRYVC
//extension ViewController: TaskViewControllerDelegate {
//    func saveTask(row: Int) {
//let defaults = UserDefaults.standard
//var tasks = defaults.stringArray(forKey: "tasks") ?? [String]()
//tasks.append(text)
//
//defaults.set(tasks, forKey: "tasks")

//
//        updateTasks()
//        tableView.reloadData()
//    }
//}
