//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Елисей Мищенко on 26.01.2022.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let cellID = "task"
    private var taskList: [Task] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }

    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearence.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 1
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc private func addNewTask() {
        showAlert(with: "New Task", and: "What do you want to do?")
    }
    
    private func fetchData() {
        let fetchRequest = Task.fetchRequest()
        
        do {
            taskList = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch data", error)
        }
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.save(task)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "New Task"
        }
        present(alert, animated: true)
    }
    private func save(_ taskName: String) {
        let task = Task(context: context)
        task.name = taskName
        taskList.append(task)
        
        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
        
        context.delete(task)
        do {
            try context.save()
        }
        catch {
              // error
        }
    }

    private func delete(at index: Int) {
        let task = Task(context: context)
        context.delete(task)
        do {
            try context.save()
        }
        catch {
              // error
        }
    }
}


extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
         
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            delete(at: indexPath.row)
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

    }
}
