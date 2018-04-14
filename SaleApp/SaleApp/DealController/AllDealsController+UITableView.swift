//
//  AllDealsController+UITableView.swift
//  SaleApp
//
//  Created by logan on 2018/4/12.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit

extension AllDealsController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DealsCell
        let deal = deals[indexPath.row]
        cell.deal = deal
        if let imageUrl = deal.image {
            if imageUrl != "None"{
                cell.dealImageView.downLoadAndCacheImageFromURL(urlString: imageUrl)
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deal = deals[indexPath.row]
        self.selectedIndexPath = indexPath
        let addDealVC = AddDealController()
        addDealVC.deal = deal
        addDealVC.client = client
        present(CustomeNavigationController(rootViewController: addDealVC), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: performDeleteRowAction)
        let editAction = UITableViewRowAction(style: .normal, title: "Track", handler: performEditAction)
        
        //deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.darkBlue
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
        print("tracking...")
    }
    
}
