//
//  TaskViewController.swift
//  CoreDataDemo
//
//  Created by Елисей Мищенко on 26.01.2022.
//

import UIKit

class TaskViewController: UIViewController {
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        createButton(
            withTitle: "Save Task",
            andColor: UIColor(
                red: 21/255,
                green: 101/255,
                blue: 192/255,
                alpha: 1
            ),
            action: UIAction { _ in
                self.dismiss(animated: true)
            })
        
    }()
    
    private lazy var canselButton: UIButton = {
        createButton(
            withTitle: "Cancel",
            andColor: UIColor(
                red: 234/255,
                green: 104/255,
                blue: 91/255,
                alpha: 1
            ),
            action: UIAction { _ in
                self.dismiss(animated: true)
            })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup(subviews: taskTextField, saveButton, canselButton)
        setConstrains()
    }
    
    private func setup(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstrains() {
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        canselButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            canselButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            canselButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            canselButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func createButton(withTitle title: String, andColor color: UIColor, action: UIAction) -> UIButton {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = color
        
        var attributes = AttributeContainer()
        
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
        
        return UIButton(configuration: buttonConfiguration, primaryAction: action)
    }
}
