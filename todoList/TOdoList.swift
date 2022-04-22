//
//  TOdoList.swift
//  todoList
//
//  Created by 曾子庭 on 2022/4/22.
//

import Foundation

struct TodoList{
    
    private let userDefault = UserDefaults.standard
    
    init(){
        loadData()
    }
    
    private(set) var strings: [String] = [] {
        didSet {
            saveData()
        }
    }
    
    
    mutating func remove(_ index: Int){
        strings.remove(at: index)
    }
    
    mutating func add(text:String?){
        guard let text = text else {
            return
        }
        strings.append(text)
    }
    
    
    //MARK: - save data
    private func saveData(){
        userDefault.set(strings, forKey: Constant.userDefaultKey)
    }
    
    private mutating func loadData(){
        strings = userDefault.stringArray(forKey: Constant.userDefaultKey) ?? []
    }
}

private extension TodoList {
    
    enum Constant {
        static let userDefaultKey: String = "data"
    }
}
