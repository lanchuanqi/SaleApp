//
//  ClientViewController.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase


class ClientViewController: UITableViewController, LoginControllerDelegate {
    let tableViewCellId = "cellId"
    var allClients: [[Client]] = [[], []]
    var selectedIndexPath: IndexPath?
    let headerNames = [ClientRole.Agency.rawValue, ClientRole.Customer.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNavigationBar()
        checkForUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func checkForUser(){
        if let _ = Auth.auth().currentUser{
            updatedDataFromDatabase()
        }
        else{
            let login = LoginController()
            login.delegate = self
            self.navigationController?.present(login, animated: true, completion: nil)
        }
    }
    private func updatedDataFromDatabase(){
        self.allClients[0].removeAll()
        self.allClients[1].removeAll()
        self.tableView.reloadData()
        
        downLoadClientInfo()
        observeChangesForClients()
    }
    
    private func setUpTableView(){
        tableView.backgroundColor = UIColor.darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.white
        tableView.register(ClientCell.self, forCellReuseIdentifier: tableViewCellId)
    }
    
    private func setUpNavigationBar(){
        navigationItem.title = "Clients"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddClient))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc private func handleLogout(){
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut()
                self.checkForUser()
            }
            catch let error{
                present(AlertCreator.shared.createAlertWithTitle(title: "Failed to log out with error: \(error.localizedDescription)"), animated: true, completion: nil) 
            }
        }
    }
    @objc private func handleAddClient(){
        let createClientController = AddClientController()
        let naviController = CustomeNavigationController(rootViewController: createClientController)
        self.present(naviController, animated: true, completion: nil)
    }
    
    
    private func downLoadClientInfo(){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference()
        ref.child("users").child(userId).child("Clients").observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary{
                var client = Client()
                client.name = dictionary["name"] as? String
                client.image = dictionary["profileImageUrl"] as? String
                client.key = dictionary["key"] as? String
                client.id = dictionary["id"] as? String
                client.phone = dictionary["phone"] as? String
                client.address = dictionary["address"] as? String
                client.profit = dictionary["profit"] as? String
                if let role = dictionary["role"] as? String{
                    client.role = role
                    if role == ClientRole.Customer.rawValue{
                        self.allClients[1].append(client)
                    } else {
                        self.allClients[0].append(client)
                    }
                } else {
                    client.role = "Customer"
                    self.allClients[1].append(client)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func observeChangesForClients(){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference()
        ref.child("users").child(userId).child("Clients").observe(.childChanged) { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                var client = Client()
                client.name = dictionary["name"] as? String
                client.image = dictionary["profileImageUrl"] as? String
                client.key = dictionary["key"] as? String
                client.id = dictionary["id"] as? String
                client.phone = dictionary["phone"] as? String
                client.address = dictionary["address"] as? String
                client.profit = dictionary["profit"] as? String
                if let indexPath = self.selectedIndexPath{
                    self.allClients[indexPath.section].remove(at: indexPath.row)
                    if let role = dictionary["role"] as? String{
                        client.role = role
                        if role == "Customer"{
                            self.allClients[1].append(client)
                        } else {
                            self.allClients[0].append(client)
                        }
                    } else {
                        client.role = "Customer"
                        self.allClients[1].append(client)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
//    private func observeDeleteActionForClients(){
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let ref = Database.database().reference()
//        ref.child("users").child(userId).child("Clients").observe(.childRemoved) { (snapshot) in
//            if let dictionary = snapshot.value as? NSDictionary {
//                var client = Client()
//                client.name = dictionary["name"] as? String
//                client.image = dictionary["profileImageUrl"] as? String
//                client.key = dictionary["key"] as? String
//                client.id = dictionary["id"] as? String
//                client.phone = dictionary["phone"] as? String
//                client.address = dictionary["address"] as? String
//                client.profit = dictionary["profit"] as? String
//                guard let index = self.clients.index(of: client) else { return }
//                self.clients.remove(at: index)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
    
    func didLogin() {
        updatedDataFromDatabase()
    }
}


//problem
//1. index wrong, always add to last












