//
//  ViewController.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let userController: UserDataControllerProtocol = NewUserDataController()
    // Switch between two implementations of CoreDataWorker
    //let userController: UserDataControllerProtocol = UserDataController()
    
    let nameTextField: UITextField = UITextField()
    let usernameTextField: UITextField = UITextField()
    let loadButton: UIButton = UIButton(type: UIButtonType.system)
    let updateButton: UIButton = UIButton(type: UIButtonType.system)
    let clearButton: UIButton = UIButton(type: UIButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(textField: nameTextField, with: "name")
        configure(textField: usernameTextField, with: "username")
        configure(button: loadButton, with: "Load", and: #selector(loadPressed))
        configure(button: updateButton, with: "Update", and: #selector(updatePressed))
        configure(button: clearButton, with: "Clear", and: #selector(clearPressed))

        view.addSubview(nameTextField)
        view.addSubview(usernameTextField)
        view.addSubview(loadButton)
        view.addSubview(updateButton)
        view.addSubview(clearButton)
        
        setupConstraints()
        loadUser()
    }
    
    private func configure(textField: UITextField, with placeholder: String? = nil){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0
        textField.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func configure(button: UIButton, with title: String, and action: Selector){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func setupConstraints(){
        
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.topAnchor,
                                               constant: 100.0).isActive = true
        
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                               constant: 20.0).isActive = true
        
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor,
                                          constant: 20.0).isActive = true
        
        loadButton.trailingAnchor.constraint(equalTo: updateButton.leadingAnchor,
                                             constant: -20).isActive = true
        loadButton.topAnchor.constraint(equalTo: updateButton.topAnchor).isActive = true
        
        clearButton.leadingAnchor.constraint(equalTo: updateButton.trailingAnchor,
                                             constant: 20).isActive = true
        clearButton.topAnchor.constraint(equalTo: updateButton.topAnchor).isActive = true
    }
    
    private func loadUser(){
        userController.fetchUser { (user) in
            guard let user = user else { return }
            self.nameTextField.text = user.name
            self.usernameTextField.text = user.username
        }
    }
    
    @objc private func updatePressed(){
        userController.updateUser(name: nameTextField.text ?? "",
                                  username: usernameTextField.text ?? "")
    }
    
    @objc private func loadPressed(){
        loadUser()
    }
    
    @objc private func clearPressed(){
        nameTextField.text = nil
        usernameTextField.text = nil
    }
}

