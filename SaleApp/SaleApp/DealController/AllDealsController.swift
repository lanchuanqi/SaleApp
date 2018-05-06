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
    var client: Client?
    let headerName = ["Not Shipped", "Shipped"]
    var allDeals: [[Deal]] = [[], []]
    
    let cellId = "cellId"
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTableView()
        observeDealAdded()
        observeChangesForDeals()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let name = client?.name{
            navigationItem.title = name
        } else {
            navigationItem.title = "Clients"
        }
    }
    override func viewDidAppear(_ animated: Bool) {
       let total = getTotalProfit()
        updateTotalProfitOnClient(profit: total)
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
                deal.profit = dictionary["profit"] as? String
                if let shipOrNot = deal.shipped{
                    if shipOrNot == "1"{
                        self.allDeals[1].append(deal)
                    } else {
                        self.allDeals[0].append(deal)
                    }
                }
                DispatchQueue.main.async {
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
                deal.profit = dictionary["profit"] as? String
                if let shipOrNot = deal.shipped{
                    if shipOrNot == "1"{
                        if self.allDeals[1].contains(where: {$0.key == deal.key}) == false{
                            self.allDeals[1].append(deal)
                            self.allDeals[0] = self.allDeals[0].filter({ (existingDeal) -> Bool in
                                return existingDeal.key != deal.key
                            })
                        } else {
                            self.updatedAllDealsAfterChange(deal: deal)
                        }
                    } else {
                        if self.allDeals[0].contains(where: {$0.key == deal.key}) == false{
                            self.allDeals[0].append(deal)
                            self.allDeals[1] = self.allDeals[1].filter({ (existingDeal) -> Bool in
                                return existingDeal.key != deal.key
                            })
                        }
                        else {
                            self.updatedAllDealsAfterChange(deal: deal)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    private func updatedAllDealsAfterChange(deal: Deal){
        if let indexPath = self.selectedIndexPath{
            self.allDeals[indexPath.section][indexPath.row] = deal
        }
    }
    
    
    
    //    // caculate profit and save to database(if total messed up call this two functions in view did appear)
        private func getTotalProfit() -> Double{
            var totalProfit = 0.0
            allDeals.forEach { (deals) in
                deals.forEach({ (deal) in
                    if let price = deal.price, let sellPrice = deal.sellPrice{
                        if let priceDouble = Double(price), let sellPriceDouble = Double(sellPrice){
                            totalProfit += (sellPriceDouble - priceDouble)
                        }
                    }
                })
            }
            return totalProfit
        }
    
        private func updateTotalProfitOnClient(profit: Double){
            guard let profitString = self.client?.profit else { return }
            if let currentProfit = Double(profitString) {
                if currentProfit == profit {
                    return
                }
            }
            
            guard let userId = Auth.auth().currentUser?.uid else { return }
            guard let clientKey = client?.key else { return }
            if let selectedClient = client{
                let values = ["name": selectedClient.name, "profileImageUrl": selectedClient.image, "key": selectedClient.key, "id": selectedClient.id, "phone": selectedClient.phone , "address": selectedClient.address, "profit": String(profit)] as [String : AnyObject]
                let ref = Database.database().reference()
                ref.child("users").child(userId).child("Clients").child(clientKey).updateChildValues(values)
            }
        }
}
