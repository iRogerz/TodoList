//
//  ViewController.swift
//  todoList
//
//  Created by roger on 2022/4/7.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //MARK: UI
    let tableView:UITableView = {
        let myTableView = UITableView()
        myTableView.separatorStyle = .singleLine
        myTableView.allowsSelection = true
        return myTableView
    }()
    
    var data = [String]()
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        setupUI()
        loadData()
    }
    
    //MARK: setupView
    func setupUI(){
        //nav
        navigationItem.title = "提醒事項"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newList))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
    //native edit func
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    @objc func newList(){
        showAlertController(title: "新增", message: "請輸入要做的事項")
    }
    
    //showAlert func
    func showAlertController(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確認", style: .default) { _ in
            if let textField = alertController.textFields,
               let inputText = textField[0].text{
                self.data.append(inputText)
                self.saveData()
                self.tableView.reloadData()
                print(inputText)
            }
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    //此方法是刪除tableview中的cell功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
            case UITableViewCell.EditingStyle.delete:
            data.remove(at: indexPath.row)
            tableView.reloadData()
            saveData()
        default:
            break
        }
    }
    //MARK: save data
    func saveData(){
        UserDefaults.standard.set(data, forKey: "data")
    }
    
    func loadData(){
        data = UserDefaults.standard.stringArray(forKey: "data") ?? []
    }
    
}


extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
}
