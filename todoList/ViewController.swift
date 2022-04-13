//
//  ViewController.swift
//  todoList
//
//  Created by 曾子庭 on 2022/4/7.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UI
    let navBar:UINavigationBar = {
        let myNavBar = UINavigationBar()
        myNavBar.backgroundColor = .brown
        let navTitle = UINavigationItem(title: "ToDo list")
        let newButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(newList))
        navTitle.rightBarButtonItem = newButton
        myNavBar.setItems([navTitle], animated: false)
        return myNavBar
    }()
    
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
        view.backgroundColor = .white
        setupUI()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    
    func setupUI(){
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom)
        }
    }
    
    @objc func newList(){
        showAlertController(title: "新增", message: "請輸入要做的事項")
    }
    
    //showcontroller
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
    
    
    //MARK: UITable func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
    
    //MARK: save data
    func saveData(){
        UserDefaults.standard.set(data, forKey: "data")
    }
    
    func loadData(){
        data = UserDefaults.standard.stringArray(forKey: "data") ?? []
    }
    
}

