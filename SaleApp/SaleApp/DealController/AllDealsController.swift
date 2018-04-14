//
//  AllDealsController.swift
//  SaleApp
//
//  Created by logan on 2018/4/9.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase

class AllDealsController: UITableViewController{
    var client: Client? {
        didSet{
            observeDealAdded()
            observeChangesForDeals()
        }
    }
    var deals = [Deal]()
    let cellId = "cellId"
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let name = client?.name{
            navigationItem.title = name
        } else {
            navigationItem.title = "Clients"
        }
    }
    private func setUpTableView(){
        tableView.backgroundColor = UIColor.darkBlue
        tableView.separatorColor = UIColor.white
        tableView.register(DealsCell.self, forCellReuseIdentifier: cellId)
    }
    private func setUpNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddDeal))
    }
    @objc private func handleAddDeal(){
        let createDealVC = AddDealController()
        createDealVC.client = client
        let naviController = CustomeNavigationController(rootViewController: createDealVC)
        self.present(naviController, animated: true, completion: nil)
    }
    
    private func observeDealAdded(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let clientKey = client?.key else { return }
        
        let ref = Database.database().reference()
        let dealRef = ref.child("users").child(uid).child("deals").child(clientKey)
        dealRef.observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                var deal = Deal()
                deal.name = dictionary["name"] as? String
                deal.key = dictionary["key"] as? String
                deal.date = dictionary["date"] as? String
                deal.price = dictionary["price"] as? String
                deal.sellPrice = dictionary["sellPrice"] as? String
                deal.shipNumber = dictionary["shipNumber"] as? String
                deal.shipped = dictionary["shipped"] as? String
                deal.image = dictionary["image"] as? String
                DispatchQueue.main.async {
                    self.deals.append(deal)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func observeChangesForDeals(){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let clientKey = client?.key else { return }
        
        let ref = Database.database().reference()
        ref.child("users").child(userId).child("deals").child(clientKey).observe(.childChanged) { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                var deal = Deal()
                deal.name = dictionary["name"] as? String
                deal.key = dictionary["key"] as? String
                deal.date = dictionary["date"] as? String
                deal.price = dictionary["price"] as? String
                deal.sellPrice = dictionary["sellPrice"] as? String
                deal.shipNumber = dictionary["shipNumber"] as? String
                deal.shipped = dictionary["shipped"] as? String
                deal.image = dictionary["image"] as? String
                if let indexPath = self.selectedIndexPath{
                    DispatchQueue.main.async {
                        self.deals[indexPath.row] = deal
                        self.tableView.reloadRows(at: [indexPath], with: .middle)
                    }
                }
            }
        }
    }

    
}
