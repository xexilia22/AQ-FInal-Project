//
//  UserManager.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation


class UserManager: ObservableObject {
    @Published var currentUser: String? {
        didSet {
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
        }
    }
    @Published var isLoggedIn: Bool = false
    
    init() {
        self.currentUser = UserDefaults.standard.string(forKey: "currentUser")
        self.isLoggedIn = false
    }
    
    func register(username: String, password: String) -> Bool {
        let users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
        
        guard users[username] == nil else {
            return false
        }
        
        var updatedUsers = users
        updatedUsers[username] = password
        UserDefaults.standard.set(updatedUsers, forKey: "users")
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        print("did run login func in UserManager")
        let users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
        
        if users[username] == password {
            currentUser = username
            isLoggedIn = true
            return true
        }
        return false
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
    
    func loadFromDefaults() {
        if let saveUser = UserDefaults.standard.string(forKey: "currentUser") {
            self.currentUser = saveUser
            self.isLoggedIn = true
            
        }
    }
    
}
