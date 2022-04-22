//
//  ViewController.swift
//  todoList
//
//  Created by roger on 2022/4/7.
//

import UIKit
import SnapKit

// Massive View Controller

// Access Control

class ViewController: UIViewController {
    
    var todoList = TodoList() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - UI
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        setupUI()
        setupNavigation()
    }
    
    private func setupNavigation(){
        navigationItem.title = "提醒事項"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newList))
    }
    
    //MARK: - setupView
    private func setupUI(){

        tableView.dataSource = self
    }
    
    //native editButton func
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    @objc private func newList(){
        // ARC weak unowned
        showTextFieldAlert(title: "新增", message: "請輸入要做的事項") {text in
            self.todoList.add(text: text)
        }
    }
}


//MARK: - UITableViewDataSource
extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let string = todoList.strings[indexPath.row]
        cell.textLabel?.text = string
        return cell
    }
    
    //此方法是刪除tableview中的cell功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(indexPath.row)
        }
    }
}
