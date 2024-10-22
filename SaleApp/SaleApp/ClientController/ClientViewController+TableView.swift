//
//  ClientViewController+TableView.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit

extension ClientViewController{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.text = headerNames[section]
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkBlue
        label.backgroundColor = UIColor.lightBlue
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.allClients.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allClients[section].count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! ClientCell
        let client = self.allClients[indexPath.section][indexPath.row]
        cell.nameLabel.text = client.name
        if let imageUrl = client.image {
            if imageUrl != "None"{
                cell.clientImageView.downLoadAndCacheImageFromURL(urlString: imageUrl)
            }
        }
        if let totalProfit = client.profit{
            cell.profitLabel.text = "Profit: \(totalProfit)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = allClients[indexPath.section][indexPath.row]
        let dealsVC = AllDealsController()
        dealsVC.client = client
        self.navigationController?.pushViewController(dealsVC, animated: true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: performDeleteRowAction)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: performEditAction)
        
        //deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.lightRed
        return [editAction]
    }
    
//    private func performDeleteRowAction(action: UITableViewRowAction, indexPath: IndexPath){
//        let company = self.companies[indexPath.row]
//        print("Attempting delete company at row \(indexPath.row) with name \(String(describing: company.name))")
//        // delete companies from tableView
//        self.companies.remove(at: indexPath.row)
//        self.tableView.deleteRows(at: [indexPath], with: .bottom)
//
//        //delete companies from CoreData
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        context.delete(company)
//        do{
//            try context.save()
//        } catch let saveError{
//            print("Delete from CoreData failed with error: \(saveError)")
//        }
//    }
    
    private func performEditAction(action: UITableViewRowAction, indexPath: IndexPath){
        let editClientController = AddClientController()
        editClientController.currentClient = self.allClients[indexPath.section][indexPath.row]
        self.selectedIndexPath = indexPath
        let naviController = CustomeNavigationController(rootViewController: editClientController)
        present(naviController, animated: true, completion: nil)
    }
    
}
